output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "private_subnets" {
  description = "Private subnets for the EKS cluster"
  value       = module.vpc.private_subnets
}

output "eks_node_sg" {
  description = "Security group ID for the EKS nodes"
  value       = aws_security_group.eks_node_sg.id
}

output "karpenter_instance_profile" {
  description = "Instance_profile for the EKS nodes"
  value       = aws_iam_instance_profile.karpenter_instance_profile.name
}

output "karpenter_role_arn" {
  description = "karpenter_role for the EKS nodes"
  value       = aws_iam_role.karpenter_controller.arn
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "karpenter_interruption_queue" {
  description = "Security group ID for the EKS nodes"
  value       = aws_sqs_queue.karpenter_interruption_queue.arn
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = module.eks.oidc_provider_arn
}
output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster"
  value       = module.eks.cluster_iam_role_name
}

output "config_instruction" {
  description = "Instruction to configure new cluster on your IDE"
  value = "Input the folowing command to configure new cluster on your IDE: aws eks update-kubeconfig --region {region} --name {cluster_name}"
}


# output "cluster_oidc_issuer" {
#   value = data.aws_eks_cluster.eks.oidc.issuer
# }


# output "iam_role_arn" {
#   value = module.eks_karpenter.iam_role_arn
# }

# output "serviceAccount_name" {
#   value = module.eks_karpenter.service_account
# }

# output "interruptionQueue" {
#   value = module.eks_karpenter.queue_name  
# }

# output "karpenter_node_iam_role_name" {
#   description = "The name of the IAM role"
#   value       = module.eks_karpenter.node_iam_role_name
# }

# output "karpenter_node_iam_role_arn" {
#   description = "The Amazon Resource Name (ARN) specifying the IAM role"
#   value       = module.eks_karpenter.node_iam_role_arn
# }

# output "karpenter_iam_role_name" {
#   description = "The name of the controller IAM role"
#   value       = module.eks_karpenter.iam_role_name
# }
