resource "kubernetes_manifest" "letsencrypt_clusterissuer" {
  count = var.enable_cluster_addons && var.enable_addon_custom_resources && var.enable_cert_manager && var.enable_ingress_nginx && var.acme_email != "" ? 1 : 0

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-prod"
    }
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = var.acme_email
        privateKeySecretRef = {
          name = "letsencrypt-prod"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = var.ingress_class_name
              }
            }
          }
        ]
      }
    }
  }

  depends_on = [
    helm_release.cert_manager,
    helm_release.ingress_nginx
  ]
}
