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

output "public_subnets" {
  description = "Public subnets for internet facing load balancers"
  value       = module.vpc.public_subnets
}

output "eks_node_sg" {
  description = "Security group ID for the EKS nodes"
  value       = module.eks.node_security_group_id
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
  description = "Interruption queue name for karpenter"
  value       = aws_sqs_queue.karpenter_interruption_queue.name
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
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region} --alias ${var.cluster_name}"
}
