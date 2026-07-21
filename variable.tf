variable "cluster_name" {
  description = "EKS cluster name"
  default     = "els-sample-cluster-2"
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
  default     = "t3.small"
}

variable "addons_node_desired_size" {
  description = "Desired node count for the add-ons managed node group"
  type        = number
  default     = 2
}

variable "addons_node_min_size" {
  description = "Minimum node count for the add-ons managed node group"
  type        = number
  default     = 1
}

variable "addons_node_max_size" {
  description = "Maximum node count for the add-ons managed node group"
  type        = number
  default     = 3
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

variable "enable_secrets_store_csi" {
  description = "Deploy the Secrets Store CSI driver"
  type        = bool
  default     = false
}

variable "enable_cert_manager" {
  description = "Deploy cert-manager"
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

variable "enable_addon_custom_resources" {
  description = "Deploy CRD-backed custom resources after their charts and CRDs already exist"
  type        = bool
  default     = false
}

variable "ingress_class_name" {
  description = "Ingress class used by cert-manager HTTPS challenges"
  type        = string
  default     = "nginx"
}

variable "acme_email" {
  description = "Email address used by the ACME ClusterIssuer"
  type        = string
  default     = ""
}

variable "cert_manager_chart_version" {
  description = "Pinned cert-manager charts version"
  type        = string
  default     = "v1.21.0"
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

variable "velero_bucket_name" {
  description = "Velero bucket name"
  type        = string
  default     = "els-app-backups"
}

variable "tags" {
  description     = "Additional tags applied to AWS resources"
  type            = map(string)
  default = {
    "Environment" = "learn"
    "Terraform"   = "true"
    "Project"     = "els-k8s-infra"
  }
}
