locals {
  argocd_github_org_url = "https://github.com/${var.github_org}"
}

resource "kubernetes_namespace_v1" "argocd" {
  count = var.enable_cluster_addons && var.enable_argocd ? 1 : 0

  metadata {
    name = var.argocd_namespace
  }
}

# Credential template: matches every repo under the org URL prefix, so Argo CD
# can read all current and future repos in the org via the GitHub App.
resource "kubernetes_secret_v1" "argocd_github_repo_creds" {
  count = var.enable_cluster_addons && var.enable_argocd && var.argocd_github_app_private_key != "" ? 1 : 0

  metadata {
    name      = "argocd-repo-creds-${lower(var.github_org)}"
    namespace = kubernetes_namespace_v1.argocd[0].metadata[0].name
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    type                    = "git"
    url                     = local.argocd_github_org_url
    githubAppID             = var.argocd_github_app_id
    githubAppInstallationID = var.argocd_github_app_installation_id
    githubAppPrivateKey     = var.argocd_github_app_private_key
  }

  type = "Opaque"
}

resource "helm_release" "argocd" {
  count            = var.enable_cluster_addons && var.enable_argocd ? 1 : 0
  name             = "argocd"
  namespace        = kubernetes_namespace_v1.argocd[0].metadata[0].name
  create_namespace = false
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  wait             = true
  timeout          = 600

  values = [
    yamlencode({
      global = {
        nodeSelector = {
          "kubernetes.io/os" = "linux"
          role               = "addons"
        }
      }
      server = {
        service = {
          type = "ClusterIP"
        }
      }
    })
  ]

  depends_on = [
    module.eks,
    kubernetes_namespace_v1.argocd,
  ]
}