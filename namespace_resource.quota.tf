resource "kubernetes_namespace_v1" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_resource_quota_v1" "dev_quota" {
  metadata {
    name      = "resource-quota"
    namespace = kubernetes_namespace_v1.dev.metadata[0].name
  }
  spec {
    hard = {
      "requests.cpu"    = "2"
      "requests.memory" = "4Gi"
      "limits.cpu"      = "4"
      "limits.memory"   = "8Gi"
    }
  }
}


resource "kubernetes_namespace_v1" "stage" {
  metadata {
    name = "stage"
  }
}

resource "kubernetes_resource_quota_v1" "stage_quota" {
  metadata {
    name      = "resource-quota"
    namespace = kubernetes_namespace_v1.stage.metadata[0].name
  }
  spec {
    hard = {
      "requests.cpu"    = "2"
      "requests.memory" = "4Gi"
      "limits.cpu"      = "4"
      "limits.memory"   = "8Gi"
    }
  }
}


resource "kubernetes_namespace_v1" "prod" {
  metadata {
    name = "prod"
  }
}

resource "kubernetes_resource_quota_v1" "prod_quota" {
  metadata {
    name      = "resource-quota"
    namespace = kubernetes_namespace_v1.prod.metadata[0].name
  }
  spec {
    hard = {
      "requests.cpu"    = "2"
      "requests.memory" = "4Gi"
      "limits.cpu"      = "4"
      "limits.memory"   = "8Gi"
    }
  }
}
