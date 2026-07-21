# AWS Bootstrap

This file contains the exact commands needed to prepare AWS and GitHub for this repository's Terraform workflows.

## Assumptions

- AWS account ID: `466798855028`
- AWS region: `us-west-1`
- GitHub org: `Elsgit1`
- GitHub repo: `els-k8s-infra`
- Terraform state bucket: `els-k8s-infra-tfstate-466798855028-us-west-1`
- Terraform state key: `els-k8s-infra/terraform.tfstate`
- IAM role name: `GitHub-OIDC`
- IAM policy name: `GitHubActionsTerraformDeployPolicy`

## Set shell variables

Run these first in Git Bash:

```bash
export AWS_ACCOUNT_ID="466798855028"
export AWS_REGION="us-west-1"
export GITHUB_ORG="Elsgit1"
export GITHUB_REPO="els-k8s-infra"

export ROLE_NAME="GitHub-OIDC"
export POLICY_NAME="GitHubActionsTerraformDeployPolicy"

export TF_STATE_BUCKET="els-k8s-infra-tfstate-466798855028-us-west-1"
export TF_STATE_KEY="els-k8s-infra/terraform.tfstate"
export TF_VAR_CLUSTER_NAME="els-sample-cluster-2"
```

## Create the S3 state bucket

```bash
aws s3api create-bucket \
  --bucket "$TF_STATE_BUCKET" \
  --region "$AWS_REGION" \
  --create-bucket-configuration "LocationConstraint=$AWS_REGION"

aws s3api put-bucket-versioning \
  --bucket "$TF_STATE_BUCKET" \
  --versioning-configuration Status=Enabled

aws s3api put-bucket-encryption \
  --bucket "$TF_STATE_BUCKET" \
  --server-side-encryption-configuration '{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "AES256"
        }
      }
    ]
  }'

aws s3api put-public-access-block \
  --bucket "$TF_STATE_BUCKET" \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
```

## Create the GitHub OIDC provider

(Skip this if the provider already exists.)

```bash
cat > create-open-id-connect-provider.json <<'EOF'
{
  "Url": "[https://token.actions.githubusercontent.com](https://token.actions.githubusercontent.com)",
  "ClientIDList": [
    "sts.amazonaws.com"
  ],
  "ThumbprintList": [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}
EOF

aws iam create-open-id-connect-provider \
  --cli-input-json file://create-open-id-connect-provider.json
```

If the CLI path keeps failing, create the provider in the AWS console instead:

1. On the AWS console, go to IAM.
2. In the left navigation panel, open `Identity Providers`.
3. Choose `Add Provider`.
4. For `Provider Type`, choose `OpenID Connect`.
5. For `Provider URL`, enter `https://token.actions.githubusercontent.com`.
6. For `Audience`, enter `sts.amazonaws.com`.
7. Review the values and create the provider.

Note: The IAM role being created below will trust the above created OIDC prodiver.


## Create the deploy role and attach policy

These commands use the policy files already committed in this repo.

```bash
aws iam create-role \
  --role-name "$ROLE_NAME" \
  --assume-role-policy-document file://.github/aws/github-oidc-trust-policy.json

aws iam create-policy \
  --policy-name "$POLICY_NAME" \
  --policy-document file://.github/aws/terraform-deploy-role-policy.json

aws iam attach-role-policy \
  --role-name "$ROLE_NAME" \
  --policy-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:policy/${POLICY_NAME}"
```

## Configure GitHub repo secrets and variables

These commands require the GitHub CLI and a login that can administer the repository.

### Required GitHub repository secrets

Create these secrets in the `Elsgit1/els-k8s-infra` repository because the GitHub Actions workflows read them directly:

```bash
gh repo set-default "${GITHUB_ORG}/${GITHUB_REPO}"

gh secret set AWS_ROLE_ARN --body "arn:aws:iam::${AWS_ACCOUNT_ID}:role/${ROLE_NAME}"
gh secret set TF_STATE_BUCKET --body "$TF_STATE_BUCKET"
```

### Required GitHub repository variables

Create these repository variables because the workflows and Terraform runtime expect them:

```bash
gh variable set AWS_REGION --body "$AWS_REGION"
gh variable set TF_STATE_KEY --body "$TF_STATE_KEY"
gh variable set TF_VAR_cluster_name --body "$TF_VAR_CLUSTER_NAME"
```

### Optional

Create this only if you want the `addons` stage to enable cert-manager automatically:

```bash
gh variable set TF_VAR_acme_email --body "you@example.com"
```

## Verify the AWS setup

```bash
aws iam get-role --role-name "$ROLE_NAME"
aws iam list-attached-role-policies --role-name "$ROLE_NAME"
aws iam list-open-id-connect-providers
aws s3api get-bucket-versioning --bucket "$TF_STATE_BUCKET"
```

## Notes

- The GitHub OIDC trust policy currently allows this repository to assume the role from pull requests and from the `main` branch.
- The Terraform workflows use S3 remote state with native S3 lockfile locking.
- The workflows will fail immediately if `AWS_ROLE_ARN`, `TF_STATE_BUCKET`, `AWS_REGION`, `TF_STATE_KEY`, or `TF_VAR_cluster_name` are missing from the repository settings.
- If the bucket or IAM resources already exist, use the corresponding `get-*`, `update-*`, or `attach-*` AWS CLI commands instead of rerunning `create-*` commands.
