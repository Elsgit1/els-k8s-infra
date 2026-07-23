module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.24"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  endpoint_private_access = true
  # Set to true so that GitHub Actions runners can access the cluster API endpoint
  # Set to `false` if using self-hosted runners which can access the endpoint.
  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true
  enable_irsa                              = true
  authentication_mode                      = "API_AND_CONFIG_MAP"

  security_group_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }

  eks_managed_node_groups = {
    addons = {
      ami_type                 = "AL2023_x86_64_STANDARD"
      capacity_type            = "ON_DEMAND"
      disk_size                = 20
      instance_types           = [var.addons_node_instance_type]
      desired_size             = var.addons_node_desired_size
      max_size                 = var.addons_node_max_size
      min_size                 = var.addons_node_min_size
      iam_role_name            = "${var.cluster_name}-addons-ng"
      iam_role_use_name_prefix = false

      labels = {
        role = "addons"
      }
      tags = {
        "karpenter.sh/discovery" = var.cluster_name
      }
    }
  }

  access_entries = {
    karpenter_nodes = {
      principal_arn = aws_iam_role.karpenter_node.arn
      type          = "EC2_LINUX"
    }
  }

  tags = local.tags
}
