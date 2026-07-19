# EKS Cluster infrastructure
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true
  enable_irsa                              = true 
  cluster_security_group_id                = aws_security_group.eks_cluster_sg.id
  iam_role_arn                             = aws_iam_role.eks_cluster_role.arn
  
  
  # Node Group configuration
  eks_managed_node_groups = {
    nodes4-addons = {
      ami_type       = "AL2023_x86_64_STANDARD"  
      instance_type = "t3.medium"
      capacity_type  = "SPOT" # For production, this will be changed to "ON_DEMAND"
    
      desired_size = 2
      max_size     = 3
      min_size     = 1
      
      labels = {
        role = "addons"
      } 

      taints = {
        # This Taint aims to keep just EKS Addons and Karpenter running on this MNG
        # The pods that do not tolerate this taint should run on nodes created by Karpenter
        addons = {
          key    = "AddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        },             
      }
    }
    nodes4-apps = {
      ami_type       = "AL2023_x86_64_STANDARD"  
      instance_type = "t3.medium"
      capacity_type  = "SPOT" # For production, this will be changed to "ON_DEMAND"

      desired_capacity = 1
      max_capacity     = 4
      min_capacity     = 1

      labels = {
        role = "apps"
      }
    }
  }  

  # Managed Add-ons
  cluster_addons = {
    # aws-ebs-csi-driver = {
    #   most_recent = true
    #   resolve_conflicts = "OVERWRITE"
    #   service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn
    # }
    coredns                 = { 
      most_recent = true
      resolve_conflicts = "OVERWRITE"
    }    
    vpc-cni                 = {
      most_recent = true
      resolve_conflicts = "OVERWRITE"
    } 
    kube-proxy              = { 
      most_recent = true
      resolve_conflicts = "OVERWRITE"
      }
    eks-pod-identity-agent  = {}
    # csi-snapshot-controller = {} 
    # cloudwatch-agent        = {}    
  }

  tags = {
    Environment = "learn"
    Terraform   = "true"
  }
}


# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action   = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_cluster_role.name
}



