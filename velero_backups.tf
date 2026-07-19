# # If S3 bucket already exists with previous backups, then no need to create a new one

# # Below step to be used in a case where a new S3 bucket is to be created
# resource "aws_s3_bucket" "velero_backup" {
#   bucket = var.velero_bucket_name
# }

# resource "aws_s3_bucket_versioning" "velero_backup" {
#   bucket = aws_s3_bucket.velero_backup.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }


# IAM Role for Velero
data "aws_iam_policy_document" "velero_policy" {
  statement {
    actions = [
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
      "ec2:CreateTags",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot",
      "ec2:DescribeTags",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "velero_policy" {
  name   = "VeleroS3AccessPolicy"
  policy = data.aws_iam_policy_document.velero_policy.json
}

resource "aws_iam_role" "velero_role" {
  name = "velero_iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "velero_policy_attach" {
  role       = aws_iam_role.velero_role.name
  policy_arn = aws_iam_policy.velero_policy.arn
}

resource "kubernetes_service_account" "velero" {
  metadata {
    name      = "velero-sa"
    namespace = "velero"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.velero_role.arn
    }
  }
}

# Velero Helm Chart Installation
resource "helm_release" "velero" {
  name       = "velero"
  namespace  = "velero"
  create_namespace = true
  chart      = "velero"
  repository = "https://vmware-tanzu.github.io/helm-charts"

  values = [
    <<EOF
configuration:
  provider: aws
  backupStorageLocation:
    name: default
    bucket: "${var.velero_bucket_name}"
    config:
      region: "${var.region}"
  volumeSnapshotLocation:
    name: default
    config:
      region: "${var.region}"

podAnnotations:
  secrets-store.csi.k8s.io/used: "true"

podVolumes:
  - name: secrets-store
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: "aws-credentials"

credentials:
  secretContents:
    cloud: |
      [default]
      aws_access_key_id=$(cat /mnt/secrets-store/aws-access-key-id)
      aws_secret_access_key=$(cat /mnt/secrets-store/aws-secret-access-key)
EOF
  ]
  depends_on = [kubernetes_manifest.secret_provider_class]
}

# Velero automated backups schedule
resource "kubernetes_manifest" "velero_backup_schedule" {
  manifest = {
    apiVersion = "velero.io/v1"
    kind       = "Schedule"
    metadata = {
      name      = "daily-backup"
      namespace = "velero"
    }
    spec = {
      schedule    = "0 1 * * *" # Daily at 1:00 AM
      template = {
        includedNamespaces = ["*"] # Include all namespaces
        excludedResources  = []   # Exclude no resources
        includedResources  = ["*"] # Include all resources
        ttl                = "168h" # Retain backup for 7 days
        snapshotVolumes    = true
      }
    }
  }
}
