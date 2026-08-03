variable "cluster_name" {
  description = "EKS cluster name"
  default     = "els-cluster"
}

## Since this is a single-user AWS account, and for simplicity sake, we used the root user ARN.
## In enterprise environment, you SHOULD NOT use root user ARN, but rather a specific user group, IAM user or role ARN.
variable "cluster_admin_principal_arn" {
  description = "ARN of the IAM principal that will be granted cluster admin privileges. In enterprise environment, you SHOULD NOT use root user ARN, but rather a specific user group, IAM user or role ARN."
  type        = string
  default     = "arn:aws:iam::466798855028:root"
}

variable "kubernetes_version" {
  description = "EKS cluster Kubernetes version"
  type        = string
  default     = "1.36"
}

variable "region" {
  description = "EKS region"
  default     = "us-west-1"
}

variable "cidr_block" {
  description = "EKS VPC cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks for worker nodes"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks for internet-facing load balancers"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "Availability zones used by the VPC and EKS cluster"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
}

variable "addons_node_instance_type" {
  description = "Instance type for the managed node group that runs cluster add-ons"
  type        = string
  default     = "t3.medium"
}

variable "addons_node_desired_size" {
  description = "Desired node count for the add-ons managed node group"
  type        = number
  default     = 3
}

variable "addons_node_min_size" {
  description = "Minimum node count for the add-ons managed node group"
  type        = number
  default     = 3
}

variable "addons_node_max_size" {
  description = "Maximum node count for the add-ons managed node group"
  type        = number
  default     = 5
}

variable "enable_cluster_addons" {
  description = "Controls in-cluster Helm and Kubernetes resources that should be deployed only after the EKS cluster exists"
  type        = bool
  default     = false
}

variable "enable_velero" {
  description = "Deploy Velero backup components"
  type        = bool
  default     = false
}

variable "enable_ingress_nginx" {
  description = "Deploy Ingress-nginx for public app ingress"
  type        = bool
  default     = false
}

variable "enable_karpenter" {
  description = "Deploy Karpenter after the EKS cluster is created"
  type        = bool
  default     = false
}

variable "enable_observability" {
  description = "Deploy the observability stack after the EKS cluster is created"
  type        = bool
  default     = false
}

variable "enable_argocd" {
  description = "Deploy ArgoCD after the EKS cluster is created"
  type        = bool
  default     = false
}

variable "ingress_class_name" {
  description = "Ingress class name created by ngress-nginx"
  type        = string
  default     = "nginx"
}

variable "ingress_nginx_chart_version" {
  description = "Pinned Ingress-nginx chart version"
  type        = string
  default     = "4.15.1"
}

variable "karpenter_chart_version" {
  description = "Pinned Karpenter chart version"
  type        = string
  default     = "1.14.0"
}

variable "karpenter_capacity_types" {
  description = "Allowed Karpenter capacity types for application nodes"
  type        = list(string)
  default     = ["spot", "on-demand"]
}

variable "karpenter_instance_categories" {
  description = "Allowed Karpenter EC2 instance categories"
  type        = list(string)
  default     = ["t", "m"]
}

variable "karpenter_cpu_limit" {
  description = "Total CPU limit available to the Karpenter node pool"
  type        = number
  default     = 20
}

variable "karpenter_memory_limit" {
  description = "Total memory limit available to the Karpenter node pool"
  type        = string
  default     = "64Gi"
}

variable "kube_prometheus_stack_chart_version" {
  description = "Pinned kube-prometheus-stack chart version"
  type        = string
  default     = "87.20.0"
}

variable "observability_namespace" {
  description = "Namespace for the observability stack"
  type        = string
  default     = "observability"
}

variable "argocd_chart_version" {
  description = "Pinned Argo CD (argo-cd) Helm chart version"
  type        = string
  default     = "10.2.2"
}

variable "argocd_namespace" {
  description = "Namespace for the Argo CD control plane"
  type        = string
  default     = "argocd"
}

variable "github_org" {
  description = "GitHub organization Argo CD watches for Kubernetes manifests"
  type        = string
  default     = "Elsgit1"
}

variable "argocd_github_app_id" {
  description = "GitHub App ID used by Argo CD for org-wide repository access"
  type        = string
  default     = ""
}

variable "argocd_github_app_installation_id" {
  description = "GitHub App installation ID for the Argo CD app on the org"
  type        = string
  default     = ""
}

variable "argocd_app_manifest_path" {
  description = "Path within each app repo where Argo CD's org-wide ApplicationSets looks for deployment manifests."
  type        = string
  default     = "k8s-deployment"
}

variable "argocd_github_app_private_key" {
  description = "PEM private key for the Argo CD GitHub App. Supplied via TF_VAR_argocd_github_app_private_key from a CI secret."
  type        = string
  default     = ""
  sensitive   = true
}

variable "addons_storage_class_name" {
  description = "Storage class name for add-ons"
  type        = string
  default     = "addons-gp3"
}

variable "loki_chart_version" {
  description = "Pinned Loki chart version"
  type        = string
  default     = "7.1.0"
}

variable "loki_storage_size" {
  description = "Persistent volume size for Loki"
  type        = string
  default     = "20Gi"
}

variable "promtail_chart_version" {
  description = "Pinned Promtail chart version"
  type        = string
  default     = "6.17.1"
}

variable "prometheus_storage_size" {
  description = "Persistent volume size for Prometheus"
  type        = string
  default     = "20Gi"
}

variable "grafana_storage_size" {
  description = "Persistent volume size for Grafana"
  type        = string
  default     = "10Gi"
}

variable "alertmanager_storage_size" {
  description = "Persistent volume size for Alertmanager"
  type        = string
  default     = "10Gi"
}

variable "tags" {
  description = "Additional tags applied to AWS resources"
  type        = map(string)
  default = {
    "Environment" = "test"
    "Terraform"   = "true"
    "Project"     = "els-k8s-infra"
  }
}
