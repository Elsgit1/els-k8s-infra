# resource "kubernetes_service_account" "karpenter" {
#   metadata {
#     name      = "karpenter"
#     namespace = "karpenter"
#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.karpenter_controller.arn
#     }
#   }
# }

# # resource "kubernetes_cluster_role_binding" "karpenter" {
# #   metadata {
# #     name = "karpenter"
# #   }
# #   role_ref {
# #     api_group = "rbac.authorization.k8s.io"
# #     kind      = "ClusterRole"
# #     name      = "karpenter"
# #   }
# #   subject {
# #     kind      = "ServiceAccount"
# #     name      = kubernetes_service_account.karpenter.metadata[0].name
# #     namespace = kubernetes_service_account.karpenter.metadata[0].namespace
# #   }
# # }
