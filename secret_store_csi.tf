# IAM Policy for Secrets Access
resource "aws_iam_policy" "secret_store_policy" {
  name = "SecretStoreCSIReadSecretsPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "*"
      }
    ]
  })
}

#IAM Role and Service Account for CSI Driver
resource "kubernetes_service_account" "secret_store_sa" {
  metadata {
    name      = "secrets-store-csi-driver-sa"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.secret_store_role.arn
    }
  }
}

resource "aws_iam_role" "secret_store_role" {
  name = "SecretStoreCSIServiceAccountRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action    = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "oidc.eks.us-west-1.amazonaws.com/id/06144E50E86AC138EB4E21B0EA1F0E30:sub" = "system:serviceaccount:kube-system:secrets-store-csi-driver-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secret_store_policy" {
  policy_arn = aws_iam_policy.secret_store_policy.arn
  role       = aws_iam_role.secret_store_role.name
}


# Helm Installation of Secrets Store CSI Driver
resource "helm_release" "secrets_store_csi_driver" {
  name       = "secrets-store-csi-driver"
  namespace  = "kube-system"
  chart      = "secrets-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"

  values = [
    <<EOF
syncSecret:
  enabled: true

serviceAccount:
  create: false
  name: secrets-store-csi-driver-sa
EOF
  ]
}


# Kubernetes SecretProviderClass for Velero
resource "kubernetes_manifest" "secret_provider_class" {
  manifest = {
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name      = "aws-credentials"
      namespace = "velero"
    }
    spec = {
      provider = "aws"
      parameters = {
        objects = <<EOT
- objectName: "aws-access-key-id"
  objectType: "secretsmanager"
- objectName: "aws-secret-access-key"
  objectType: "secretsmanager"
EOT
      }
    }
  }
}
