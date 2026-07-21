resource "kubernetes_namespace_v1" "karpenter" {
  count = var.enable_cluster_addons && var.enable_karpenter ? 1 : 0

  metadata {
    name = "karpenter"
  }
}

resource "helm_release" "karpenter_crd" {
  count            = var.enable_cluster_addons && var.enable_karpenter ? 1 : 0
  name             = "karpenter-crd"
  namespace        = kubernetes_namespace_v1.karpenter[0].metadata[0].name
  create_namespace = false
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter-crd"
  version          = var.karpenter_chart_version
  wait             = true
  timeout          = 900

  depends_on = [module.eks, kubernetes_namespace_v1.karpenter]
}

resource "helm_release" "karpenter" {
  count            = var.enable_cluster_addons && var.enable_karpenter ? 1 : 0
  name             = "karpenter"
  namespace        = kubernetes_namespace_v1.karpenter[0].metadata[0].name
  create_namespace = false
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  version          = var.karpenter_chart_version
  wait             = true
  timeout          = 900

  values = [
    yamlencode({
      settings = {
        clusterName       = module.eks.cluster_name
        clusterEndpoint   = module.eks.cluster_endpoint
        interruptionQueue = aws_sqs_queue.karpenter_interruption_queue.name
      }
      serviceAccount = {
        create = true
        name   = "karpenter"
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.karpenter_controller.arn
        }
      }
      controller = {
        resources = {
          requests = {
            cpu    = "250m"
            memory = "512Mi"
          }
          limits = {
            cpu    = "1"
            memory = "1Gi"
          }
        }
      }
      nodeSelector = local.addons_node_selector
    })
  ]

  depends_on = [
    module.eks,
    kubernetes_namespace_v1.karpenter,
    helm_release.karpenter_crd,
    aws_iam_role_policy_attachment.karpenter_controller,
    aws_sqs_queue_policy.karpenter_interruption_queue,
    aws_sqs_queue.karpenter_interruption_queue
  ]
}

resource "kubernetes_manifest" "karpenter_node_class" {
  count = var.enable_cluster_addons && var.enable_karpenter && var.enable_addon_custom_resources ? 1 : 0

  manifest = {
    apiVersion = "karpenter.k8s.aws/v1"
    kind       = "EC2NodeClass"
    metadata = {
      name = "default"
    }
    spec = {
      amiFamily = "AL2023"
      amiSelectorTerms = [
        {
          alias = "al2023@latest"
        }
      ]
      instanceProfile    = aws_iam_instance_profile.karpenter_instance_profile.name
      subnetSelectorTerms = [
        {
          tags = {
            "karpenter.sh/discovery" = var.cluster_name
          }
        }
      ]
      securityGroupSelectorTerms = [
        {
          tags = {
            "karpenter.sh/discovery" = var.cluster_name
          }
        }
      ]
    }
  }

  depends_on = [helm_release.karpenter]
}

resource "kubernetes_manifest" "karpenter_node_pool" {
  count = var.enable_cluster_addons && var.enable_karpenter && var.enable_addon_custom_resources ? 1 : 0

  manifest = {
    apiVersion = "karpenter.sh/v1"
    kind       = "NodePool"
    metadata = {
      name = "apps"
    }
    spec = {
      template = {
        spec = {
          nodeClassRef = {
            group = "karpenter.k8s.aws"
            kind  = "EC2NodeClass"
            name  = "default"
          }
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = ["amd64"]
            },
            {
              key      = "kubernetes.io/os"
              operator = "In"
              values   = ["linux"]
            },
            {
              key      = "karpenter.sh/capacity-type"
              operator = "In"
              values   = var.karpenter_capacity_types
            },
            {
              key      = "karpenter.k8s.aws/instance-category"
              operator = "In"
              values   = var.karpenter_instance_categories
            },
            {
              key      = "karpenter.k8s.aws/instance-generation"
              operator = "Gt"
              values   = ["2"]
            }
          ]
          expireAfter = "720h"
        }
      }
      limits = {
        cpu    = tostring(var.karpenter_cpu_limit)
        memory = var.karpenter_memory_limit
      }
      disruption = {
        consolidationPolicy = "WhenEmptyOrUnderutilized"
        consolidateAfter    = "1m"
      }
    }
  }

  depends_on = [kubernetes_manifest.karpenter_node_class]
}
