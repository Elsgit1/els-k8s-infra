locals {
  tags = merge(
    var.tags,
    {
      Cluster = var.cluster_name
    }
  )

  cluster_oidc_issuer = replace(module.eks.cluster_oidc_issuer_url, "https://", "")

  addons_node_selector = {
    role = "addons"
  }
}
