moved {
  from = module.eks.module.eks_managed_node_group["addons"].aws_eks_node_group.this[0]
  to   = aws_eks_node_group.addons
}

moved {
  from = module.eks.module.eks_managed_node_group["addons"].aws_launch_template.this[0]
  to   = aws_launch_template.addons_node_group
}

moved {
  from = module.eks.module.eks_managed_node_group["addons"].aws_iam_role.this[0]
  to   = aws_iam_role.addons_node_group
}

moved {
  from = module.eks.module.eks_managed_node_group["addons"].aws_iam_role_policy_attachment.this["AmazonEKSWorkerNodePolicy"]
  to   = aws_iam_role_policy_attachment.addons_node_group_worker
}

moved {
  from = module.eks.module.eks_managed_node_group["addons"].aws_iam_role_policy_attachment.this["AmazonEC2ContainerRegistryReadOnly"]
  to   = aws_iam_role_policy_attachment.addons_node_group_ecr
}

moved {
  from = module.eks.module.eks_managed_node_group["addons"].aws_iam_role_policy_attachment.this["AmazonEKS_CNI_Policy"]
  to   = aws_iam_role_policy_attachment.addons_node_group_cni
}