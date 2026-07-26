locals {
  cluster_admin_principal_enabled = trimspace(var.cluster_admin_principal_arn) != ""
}

resource "aws_eks_access_entry" "cluster_admin" {
  count = local.cluster_admin_principal_enabled ? 1 : 0

  cluster_name  = module.eks.cluster_name
  principal_arn = var.cluster_admin_principal_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "cluster_admin" {
  count = local.cluster_admin_principal_enabled ? 1 : 0

  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.cluster_admin[0].principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}