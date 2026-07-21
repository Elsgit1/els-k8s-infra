# els-k8s-infra

Terraform code for a AWS EKS platform with:

- Worker nodes in private subnets
- Public-facing application access through ingress-nginx
- A dedicated managed node group for cluster add-ons
- Karpenter-managed application nodes
- Core EKS add-ons and some optional addons

## Deployment model

This configuration is staged so that `terraform plan` can succeed before a cluster exists and so CI/CD can promote the infrastructure safely.

### Stage 1: Base infrastructure

Run Terraform with the default variables to plan or deploy:

- VPC
- EKS control plane
- Managed node group for cluster add-ons
- IAM roles for EBS CSI and Karpenter
- Karpenter interruption queue and event rules

The default value of `enable_cluster_addons` is `false`, which keeps Helm and Kubernetes resources out of the initial plan.

### Stage 2: In-cluster add-ons

After the cluster exists, enable the in-cluster resources by setting:

- `enable_cluster_addons = true`
- `enable_ingress_nginx = true`
- `enable_karpenter = true`

Optional:

- `enable_cert_manager = true`
- `acme_email = "you@example.com"`

## Notes

- Business applications are expected to run on Karpenter-provisioned nodes.
- The managed node group is reserved for add-ons via the `AddonsOnly` taint.
- Public application access is intended to come through the ingress-nginx LoadBalancer service.
- The legacy manual Karpenter manifests have been removed in favor of Terraform-managed resources.

## GitHub Actions

The repository uses two GitHub Actions workflows:

- [.github/workflows/terraform-pr-plan.yml](.github/workflows/terraform-pr-plan.yml)
- [.github/workflows/terraform-main-apply.yml](.github/workflows/terraform-main-apply.yml)

AWS IAM policy templates for GitHub OIDC are included at [.github/aws/github-oidc-trust-policy.json](.github/aws/github-oidc-trust-policy.json) and [.github/aws/terraform-deploy-role-policy.json](.github/aws/terraform-deploy-role-policy.json).

The exact bootstrap commands for this repository are documented in [.github/aws/README.md](.github/aws/README.md).

### Required GitHub secrets

- `AWS_ROLE_ARN`: IAM role assumed by GitHub Actions through OIDC
- `TF_STATE_BUCKET`: S3 bucket that stores Terraform state

### Recommended GitHub variables

- `AWS_REGION`: defaults to `us-west-1`
- `TF_STATE_KEY`: defaults to `els-k8s-infra/terraform.tfstate`
- `TF_VAR_cluster_name`: override the cluster name used by Terraform
- `TF_VAR_acme_email`: set this only if `enable_cert_manager` will be used

The exact values to create for this repository are documented in [.github/aws/README.md](.github/aws/README.md).

### Workflow behavior

- Pull requests to `main` run `terraform fmt`, `terraform validate`, and real Terraform plans for both the `base` and `addons` stages
- PR plans use the remote S3 backend and update the PR with stage-specific plan comments so reviewers can inspect the exact changes before approving
- Pushes to `main` run automatic `terraform apply -auto-approve` in stage order: `base` first, then `addons`
- Both workflows only run when Terraform files, the lock file, workflow files, or GitHub AWS policy templates change
- Each workflow writes a temporary `backend_override.tf` file so GitHub Actions can use S3 state without forcing local developers onto the same backend setup

### Important sequencing

- The PR workflow shows both stages separately so reviewers can see what the base infrastructure and in-cluster add-ons would each change
- The main apply workflow automatically applies the `base` stage before applying the `addons` stage against the same remote state
- Local validation can continue using the normal `terraform init` and `terraform plan` flow

### Backend note

- Yes, the CI/CD workflows are configured to store Terraform state in S3 with native S3 lockfile locking
- This uses Terraform's `use_lockfile = true` support in the S3 backend
- The S3 backend is configured at workflow runtime with `TF_STATE_BUCKET`, `TF_STATE_KEY`, and `AWS_REGION`
- It is intentionally not hardcoded in the Terraform source so local development remains simple

### Local planning before S3 exists

You can still run Terraform locally before the remote S3 backend has been created because the backend is not hardcoded in the Terraform source.

Use:

```bash
terraform init -reconfigure
terraform validate
terraform plan
```

If Terraform complains about backend initialization because of old local metadata, run:

```bash
terraform init -reconfigure -backend=false
terraform plan
```

Notes:

- This local plan uses local state, not the future shared S3 state.
- If no local state exists yet, Terraform will show a full create plan.
- Do not create a local `backend_override.tf` unless you intentionally want your local setup to mirror the remote backend.

### AWS bootstrap notes

- Create or confirm the AWS OIDC provider for `token.actions.githubusercontent.com` in the target account
- Create the deploy role, attach the deploy policy, and store its ARN in the `AWS_ROLE_ARN` GitHub secret
- Create the S3 state bucket before the first pipeline run and enable bucket versioning on it
