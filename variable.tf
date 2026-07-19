variable "cluster_name" {
  description = "EKS cluster name"
  default     = "els-sample-cluster-2"
}

variable "region" {
  description = "EKS region"
  default     = "us-west-1"
}

variable "cidr_block" {
  description = "EKS VPC cidr"
  type = string
  default = "10.1.0.0/16"
}

variable "velero_bucket_name" {
  description = "velero bucket name"
  default     = "els-app-backups"
}

# variable "oidc_provider_arn" {
#   description = "The ARN of the existing OIDC provider"
#   type        = string
# }

# variable "oidc_provider_url" {
#   description = "The URL of the existing OIDC provider"
#   type        = string
# }
