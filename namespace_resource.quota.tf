# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_resource_quota" "dev_quota" {
  metadata {
    name      = "resource-quota"
    namespace = kubernetes_namespace.dev.metadata[0].name
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


resource "kubernetes_namespace" "stage" {
  metadata {
    name = "stage"
  }
}

resource "kubernetes_resource_quota" "stage_quota" {
  metadata {
    name      = "resource-quota"
    namespace = kubernetes_namespace.stage.metadata[0].name
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


resource "kubernetes_namespace" "prod" {
  metadata {
    name = "prod"
  }
}

resource "kubernetes_resource_quota" "prod_quota" {
  metadata {
    name      = "resource-quota"
    namespace = kubernetes_namespace.prod.metadata[0].name
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
