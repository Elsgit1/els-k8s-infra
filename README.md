# els-k8s-infra

Terraform code that builds and runs a small AWS EKS cluster, along with cluster add-ons deployed on top of it.

## How the cluster is architected

- A VPC hosts the cluster; worker nodes sit in private subnets, not exposed directly to the internet.
- A default EC2 node-group runs the cluster add-ons (ingress, observability apps, Argocd, etc).
- Business applications run on separate nodes that Karpenter creates and scales automatically based on demand.
- Public traffic can be configured to reach applications through an ingress-nginx load balancer.

## Add-ons included

- **ingress-nginx** - routes external traffic into the cluster.
- **Karpenter** - automatically provisions and scales the nodes that run business applications.
- **Observability stack** - Prometheus, Grafana, and Loki/Promtail, for metrics, dashboards, and logs.
- **Argo CD** - GitOps engine that deploys applications into the cluster by syncing from our GitHub org.

## How it's deployed

There's no manual deployment here - everything goes through a CI GitHub Actions piplines. Deployment happens in two steps:

1. **Base infrastructure** - the VPC, the EKS cluster, and the add-ons node group.
2. **Add-ons** - once the cluster exists, ingress-nginx, Karpenter, the observability stack, and Argo CD are installed on top of it.

Splitting it this way lets the pipeline safely create the cluster first, then layer everything else on it.

## GitHub Actions workflows

- **PR plan** - on every pull request, Terraform validates the code and shows a preview of what would change, so reviewers can see the impact before merging.
- **Main apply** - once a pull request merges to `main`, Terraform automatically applies the change: base infrastructure first, then add-ons.
- **Manual destroy** - a manually triggered workflow used to safely tear down a cluster, in the reverse order it was built, when the cluster is no longer needed. It requires typing `DESTROY` to confirm.

Terraform state (the record of what's deployed) is stored remotely in S3, so every run - from a pull request or a merge - works off the same shared source of truth.

## Getting started

To bootstrap this repository for a new AWS account (IAM role, secrets, and GitHub variables), see [.github/aws/README.md](.github/aws/README.md).