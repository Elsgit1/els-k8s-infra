resource "helm_release" "cert_manager" {
  count            = var.enable_cluster_addons && var.enable_cert_manager ? 1 : 0
  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true
  timeout          = 900

  repository = "oci://quay.io/jetstack/charts"
  chart      = "cert-manager"
  version    = var.cert_manager_chart_version

  set = [
    {
      name  = "crds.enabled"
      value = "true"
    },
    {
      name  = "replicaCount"
      value = "2"
    },
    {
      name  = "extraArgs[0]"
      value = "--enable-certificate-owner-ref=true"
    },
    {
      name  = "global.nodeSelector.role"
      value = "addons"
    },
  ]

  depends_on = [module.eks]
}