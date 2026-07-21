resource "helm_release" "ingress_nginx" {
  count            = var.enable_cluster_addons && var.enable_ingress_nginx ? 1 : 0
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = var.ingress_nginx_chart_version
  wait             = true
  timeout          = 900

  values = [
    yamlencode({
      controller = {
        replicaCount = 2
        ingressClassResource = {
          name = var.ingress_class_name
        }
        service = {
          type = "LoadBalancer"
          annotations = {
            "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internet-facing"
          }
        }
        nodeSelector = {
          role = "addons"
        }
      }
    })
  ]

  depends_on = [module.eks]
}
