resource "aws_iam_instance_profile" "karpenter_instance_profile" {
  name = "KarpenterInstanceProfile-els-learn-k8s-2"
  role = aws_iam_role.karpenter_controller.name
}

#Karpenter SQS
resource "aws_sqs_queue" "karpenter_interruption_queue" {
  name = "karpenter-interruption-queue"
}

#Assume role policies
data "aws_caller_identity" "current" {}

#Create IAM roles for Karpenter Controller v2
resource "aws_iam_role" "karpenter_controller" {
  name = "karpenter-controller"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::339713063356:oidc-provider/oidc.eks.us-west-1.amazonaws.com/id/06144E50E86AC138EB4E21B0EA1F0E30"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "oidc.eks.us-west-1.amazonaws.com/id/06144E50E86AC138EB4E21B0EA1F0E30:sub" = "system:serviceaccount:karpenter:karpenter-sa"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy" "karpenter_controller_policy" {
  role = aws_iam_role.karpenter_controller.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:RunInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:TerminateInstances",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeLaunchTemplates",
          "ec2:CreateTags",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplates",
          "iam:PassRole"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "sts:AssumeRole"
        ],
        Resource = "*"
      },
      {
            "Action": "ec2:TerminateInstances",
            "Condition": {
                "StringLike": {
                    "ec2:ResourceTag/karpenter.sh/discovery": "*"
                }
            },
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "ConditionalEC2Termination"
        },
        {
            "Effect": "Allow",
            "Action": "pricing:GetProducts",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::339713063356:role/KarpenterNodeRole-els-learn-k8s-2",
            "Sid": "PassNodeIAMRole"
        },
        {
            "Effect": "Allow",
            "Action": "eks:DescribeCluster",
            "Resource": "arn:aws:eks:us-west-1:339713063356:cluster/els-learn-k8s-2",
            "Sid": "EKSClusterEndpointLookup"
        },
        {
            "Sid": "AllowInstanceProfileReadActions",
            "Effect": "Allow",
            "Resource": "*",
            "Action": "iam:GetInstanceProfile"
        }
    ]
  })
}



#Karpenter Controller Policies
resource "aws_iam_role_policy_attachment" "controller_ec2_full_access" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "controller_ssm_full_access" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "controller_eks_cluster_policy" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "controller_ecr_readonly" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "controller_node" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "controller_cni" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


#########################################################################
#Create IAM roles for Karpenter Node
resource "aws_iam_role" "karpenter_node" {
  name               = "KarpenterNodeRole"
  assume_role_policy = data.aws_iam_policy_document.karpenter_node_assume_role_policy.json
}


data "aws_iam_policy_document" "karpenter_node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "karpenter_node_policy" {
  role = aws_iam_role.karpenter_node.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:RunInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:TerminateInstances",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeLaunchTemplates",
          "ec2:CreateTags",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplates",
          "iam:PassRole"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "sts:AssumeRole"
        ],
        Resource = "*"
      },
      {
            "Action": "ec2:TerminateInstances",
            "Condition": {
                "StringLike": {
                    "ec2:ResourceTag/karpenter.sh/discovery": "*"
                }
            },
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "ConditionalEC2Termination"
        },
        {
            "Effect": "Allow",
            "Action": "pricing:GetProducts",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::339713063356:role/KarpenterNodeRole",
            "Sid": "PassNodeIAMRole"
        },
        {
            "Effect": "Allow",
            "Action": "eks:DescribeCluster",
            "Resource": "arn:aws:eks:us-west-1:339713063356:cluster/els-learn-k8s-2",
            "Sid": "EKSClusterEndpointLookup"
        },
        {
            "Sid": "AllowInstanceProfileReadActions",
            "Effect": "Allow",
            "Resource": "*",
            "Action": "iam:GetInstanceProfile"
        }
    ]
  })
}

#Karpenter Node Policy
resource "aws_iam_role_policy_attachment" "node_ec2_full_access" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "node_eks_cluster_policy" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "node_ssm_full_access" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "node_ecr_readonly" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node_worker" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_cni" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}




# # Create OIDC provider
# data "aws_eks_cluster" "eks" {
#   name = module.eks.cluster_name
# }

# data "aws_eks_cluster_auth" "eks" {
#   name = module.eks.cluster_name
# }

# resource "aws_iam_openid_connect_provider" "oidc_provider" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.aws_eks_cluster.eks.certificate_authority[0].data]
#   url             = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
# }


# #Create IAM roles for Karpenter Controller
# resource "aws_iam_role" "karpenter_controller" {
#   name               = "KarpenterControllerRole"
#   assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role_policy.json
# }

# data "aws_iam_policy_document" "karpenter_controller_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["eks.amazonaws.com"]
#     }
#   }
# }

# data "aws_iam_policy_document" "karpenter_controller_policy" {
#   statement {
#     actions = [
#       "ssm:GetParameter",
#       "ec2:DescribeImages",
#       "ec2:RunInstances",
#       "ec2:DescribeSubnets",
#       "ec2:DescribeSecurityGroups",
#       "ec2:DescribeLaunchTemplates",
#       "ec2:DescribeInstances",
#       "ec2:DescribeInstanceTypes",
#       "ec2:DeleteLaunchTemplate",
#       "ec2:CreateTags",
#       "ec2:CreateLaunchTemplate",
#       "ec2:CreateFleet"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_policy" "karpenter_controller_policy" {
#   name        = "karpenter-controller-policy"
#   description = "Policy for Karpenter controller to manage node autoscaling"
#   policy      = data.aws_iam_policy_document.karpenter_controller_policy.json
# }

# resource "aws_iam_role_policy_attachment" "karpenter_controller_policy_attachment" {
#   role       = aws_iam_role.karpenter_controller.name
#   policy_arn = aws_iam_policy.karpenter_controller_policy.arn
# }

