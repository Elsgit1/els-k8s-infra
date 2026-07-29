locals {
  addons_node_group_name = "addons"
  addons_node_group_tags = merge(
    local.tags,
    {
      Name                     = local.addons_node_group_name
      "karpenter.sh/discovery" = var.cluster_name
    }
  )
}

data "aws_iam_policy_document" "addons_node_group_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "addons_node_group" {
  name               = "${var.cluster_name}-addons-ng"
  assume_role_policy = data.aws_iam_policy_document.addons_node_group_assume_role.json

  force_detach_policies = true
  tags                  = local.addons_node_group_tags
}

resource "aws_iam_role_policy_attachment" "addons_node_group_worker" {
  role       = aws_iam_role.addons_node_group.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "addons_node_group_ecr" {
  role       = aws_iam_role.addons_node_group.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "addons_node_group_cni" {
  role       = aws_iam_role.addons_node_group.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_launch_template" "addons_node_group" {
  name_prefix = "${local.addons_node_group_name}-"
  description = "Custom launch template for addons EKS managed node group"

  update_default_version = true
  vpc_security_group_ids = [module.eks.node_security_group_id]

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }

  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.addons_node_group_tags
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = local.addons_node_group_tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.addons_node_group_tags
  }

  tags = local.addons_node_group_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eks_node_group" "addons" {
  cluster_name  = module.eks.cluster_name
  node_role_arn = aws_iam_role.addons_node_group.arn
  subnet_ids    = module.vpc.private_subnets

  node_group_name_prefix = "${local.addons_node_group_name}-"

  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "ON_DEMAND"
  instance_types = [var.addons_node_instance_type]
  labels = {
    role = "addons"
  }
  version = module.eks.cluster_version

  scaling_config {
    min_size     = var.addons_node_min_size
    max_size     = var.addons_node_max_size
    desired_size = var.addons_node_desired_size
  }

  launch_template {
    id      = aws_launch_template.addons_node_group.id
    version = tostring(aws_launch_template.addons_node_group.default_version)
  }

  update_config {
    max_unavailable_percentage = 33
  }

  tags = local.addons_node_group_tags

  depends_on = [
    module.eks,
    aws_iam_role_policy_attachment.addons_node_group_worker,
    aws_iam_role_policy_attachment.addons_node_group_ecr,
    aws_iam_role_policy_attachment.addons_node_group_cni,
  ]
}