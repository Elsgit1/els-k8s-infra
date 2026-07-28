resource "kubernetes_namespace_v1" "observability" {
  count = var.enable_cluster_addons && var.enable_observability ? 1 : 0

  metadata {
    name = var.observability_namespace
  }
}

resource "helm_release" "loki" {
  count            = var.enable_cluster_addons && var.enable_observability ? 1 : 0
  name             = "loki"
  namespace        = kubernetes_namespace_v1.observability[0].metadata[0].name
  create_namespace = false
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  version          = var.loki_chart_version
  wait             = true
  timeout          = 600

  values = [
    yamlencode({
      deploymentMode = "SingleBinary"
      loki = {
        auth_enabled = false
        commonConfig = {
          replication_factor = 1
        }
        schemaConfig = {
          configs = [
            {
              from         = "2024-01-01"
              store        = "tsdb"
              object_store = "filesystem"
              schema       = "v13"
              index = {
                prefix = "loki_index_"
                period = "24h"
              }
            }
          ]
        }
        storage = {
          type = "filesystem"
        }
      }
      singleBinary = {
        replicas = 1
        persistence = {
          enabled = true
          size    = var.loki_storage_size
        }
        nodeSelector = local.addons_node_selector
      }
      backend = {
        replicas = 0
      }
      read = {
        replicas = 0
      }
      write = {
        replicas = 0
      }
      chunksCache = {
        replicas = 0
      }
      resultsCache = {
        replicas = 0
      }
      gateway = {
        enabled = false
      }
      monitoring = {
        serviceMonitor = {
          enabled = true
        }
      }
    })
  ]

  depends_on = [
    module.eks,
    kubernetes_namespace_v1.observability,
  ]
}

resource "helm_release" "promtail" {
  count            = var.enable_cluster_addons && var.enable_observability ? 1 : 0
  name             = "promtail"
  namespace        = kubernetes_namespace_v1.observability[0].metadata[0].name
  create_namespace = false
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "promtail"
  version          = var.promtail_chart_version
  wait             = true
  timeout          = 600

  values = [
    yamlencode({
      config = {
        clients = [
          {
            url = "http://loki:3100/loki/api/v1/push"
          }
        ]
      }
      serviceMonitor = {
        enabled = true
      }
    })
  ]

  depends_on = [
    module.eks,
    kubernetes_namespace_v1.observability,
    helm_release.loki,
  ]
}

resource "helm_release" "kube_prometheus_stack" {
  count            = var.enable_cluster_addons && var.enable_observability ? 1 : 0
  name             = "kube-prometheus-stack"
  namespace        = kubernetes_namespace_v1.observability[0].metadata[0].name
  create_namespace = false
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = var.kube_prometheus_stack_chart_version
  wait             = true
  timeout          = 600

  values = [
    yamlencode({
      grafana = {
        service = {
          type = "ClusterIP"
        }
        nodeSelector = local.addons_node_selector
        persistence = {
          enabled = true
          size    = var.grafana_storage_size
        }
        additionalDataSources = [
          {
            name      = "Loki"
            type      = "loki"
            access    = "proxy"
            url       = "http://loki:3100"
            isDefault = false
          }
        ]
      }
      prometheusOperator = {
        nodeSelector = local.addons_node_selector
      }
      kubeStateMetrics = {
        nodeSelector = local.addons_node_selector
      }
      alertmanager = {
        alertmanagerSpec = {
          nodeSelector = local.addons_node_selector
          storage = {
            volumeClaimTemplate = {
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources = {
                  requests = {
                    storage = var.alertmanager_storage_size
                  }
                }
              }
            }
          }
        }
      }
      prometheus = {
        prometheusSpec = {
          nodeSelector = local.addons_node_selector
          storageSpec = {
            volumeClaimTemplate = {
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources = {
                  requests = {
                    storage = var.prometheus_storage_size
                  }
                }
              }
            }
          }
        }
      }
    })
  ]

  depends_on = [
    module.eks,
    kubernetes_namespace_v1.observability,
    helm_release.loki,
  ]
}