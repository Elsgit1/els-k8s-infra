# IAM Role for EBS CSI Driver
resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "eks-ebs-csi-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Create a custom IAM policy for the EBS CSI driver
resource "aws_iam_policy" "ebs_csi_driver_policy" {
  name        = "EBS_CSI_Driver_Policy"
  description = "Policy for EBS CSI driver to interact with EBS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateSnapshot",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:DeleteVolume",
          "ec2:CreateVolume",
          "ec2:ModifyVolume",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumesModifications",
          "ec2:ModifyVolume",
          "ec2:DescribeVolumeStatus"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the custom policy to the EBS CSI driver role
resource "aws_iam_role_policy_attachment" "ebs_csi_driver_custom_policy" {
  role       = aws_iam_role.ebs_csi_driver_role.name
  policy_arn = aws_iam_policy.ebs_csi_driver_policy.arn
}


