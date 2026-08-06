Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore1)
$ cat <<'EOF' > backend_override.tf
terraform {
  backend "s3" {
    use_lockfile = true
  }
}
EOF

terraform init -reconfigure \
  -backend-config="bucket=els-k8s-infra-tfstate-466798855028-us-west-1" \
  -backend-config="key=els-k8s-infra/terraform.tfstate" \
  -backend-config="region=us-west-1"

terraform state list
Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/time from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/cloudinit from the dependency lock file
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Reusing previous version of hashicorp/helm from the dependency lock file
- Reusing previous version of hashicorp/null from the dependency lock file
- Finding alekc/kubectl versions matching "~> 2.1"...
- Reusing previous version of hashicorp/tls from the dependency lock file
- Using previously-installed hashicorp/time v0.14.0
- Using previously-installed hashicorp/aws v6.55.0
- Using previously-installed hashicorp/cloudinit v2.4.0
- Using previously-installed hashicorp/kubernetes v3.2.1
- Using previously-installed hashicorp/helm v3.2.0
- Using previously-installed hashicorp/null v3.3.0
- Installing alekc/kubectl v2.4.1...
- Installed alekc/kubectl v2.4.1 (self-signed, key ID 772FB27A86DAFCE7)
- Using previously-installed hashicorp/tls v4.3.0
Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://developer.hashicorp.com/terraform/cli/plugins/signing

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
data.aws_caller_identity.current
data.aws_eks_addon_version.aws_ebs_csi_driver
data.aws_eks_addon_version.coredns
data.aws_eks_addon_version.eks_pod_identity_agent
data.aws_eks_addon_version.kube_proxy
data.aws_eks_addon_version.vpc_cni
data.aws_iam_policy_document.addons_node_group_assume_role
data.aws_iam_policy_document.ebs_csi_driver_assume_role
data.aws_iam_policy_document.karpenter_controller
data.aws_iam_policy_document.karpenter_controller_assume_role
data.aws_iam_policy_document.karpenter_interruption_queue
data.aws_iam_policy_document.karpenter_node_assume_role_policy
data.aws_partition.current
aws_cloudwatch_event_rule.karpenter_instance_state_change
aws_cloudwatch_event_rule.karpenter_rebalance
aws_cloudwatch_event_rule.karpenter_scheduled_change
aws_cloudwatch_event_rule.karpenter_spot_interruption
aws_cloudwatch_event_target.karpenter_instance_state_change
aws_cloudwatch_event_target.karpenter_rebalance
aws_cloudwatch_event_target.karpenter_scheduled_change
aws_cloudwatch_event_target.karpenter_spot_interruption
aws_eks_access_entry.cluster_admin[0]
aws_eks_access_policy_association.cluster_admin[0]
aws_eks_addon.aws_ebs_csi_driver
aws_eks_addon.coredns
aws_eks_addon.eks_pod_identity_agent
aws_eks_addon.kube_proxy
aws_eks_addon.vpc_cni
aws_eks_node_group.addons
aws_iam_instance_profile.karpenter_instance_profile
aws_iam_policy.karpenter_controller
aws_iam_role.addons_node_group
aws_iam_role.ebs_csi_driver_role
aws_iam_role.karpenter_controller
aws_iam_role.karpenter_node
aws_iam_role_policy_attachment.addons_node_group_cni
aws_iam_role_policy_attachment.addons_node_group_ecr
aws_iam_role_policy_attachment.addons_node_group_worker
aws_iam_role_policy_attachment.ebs_csi_driver_custom_policy
aws_iam_role_policy_attachment.karpenter_controller
aws_iam_role_policy_attachment.karpenter_node_cni
aws_iam_role_policy_attachment.karpenter_node_ecr
aws_iam_role_policy_attachment.karpenter_node_ssm
aws_iam_role_policy_attachment.karpenter_node_worker
aws_launch_template.addons_node_group
aws_sqs_queue.karpenter_interruption_queue
aws_sqs_queue_policy.karpenter_interruption_queue
module.eks.data.aws_caller_identity.current[0]
module.eks.data.aws_iam_policy_document.assume_role_policy[0]
module.eks.data.aws_iam_session_context.current[0]
module.eks.data.aws_partition.current[0]
module.eks.data.tls_certificate.this[0]
module.eks.aws_cloudwatch_log_group.this[0]
module.eks.aws_ec2_tag.cluster_primary_security_group["Cluster"]
module.eks.aws_ec2_tag.cluster_primary_security_group["Environment"]
module.eks.aws_ec2_tag.cluster_primary_security_group["Project"]
module.eks.aws_ec2_tag.cluster_primary_security_group["Terraform"]
module.eks.aws_eks_access_entry.this["cluster_creator"]
module.eks.aws_eks_access_entry.this["karpenter_nodes"]
module.eks.aws_eks_access_policy_association.this["cluster_creator_admin"]
module.eks.aws_eks_cluster.this[0]
module.eks.aws_iam_openid_connect_provider.oidc_provider[0]
module.eks.aws_iam_policy.cluster_encryption[0]
module.eks.aws_iam_role.this[0]
module.eks.aws_iam_role_policy_attachment.cluster_encryption[0]
module.eks.aws_iam_role_policy_attachment.this["AmazonEKSClusterPolicy"]
module.eks.aws_security_group.cluster[0]
module.eks.aws_security_group.node[0]
module.eks.aws_security_group_rule.cluster["ingress_nodes_443"]
module.eks.aws_security_group_rule.node["egress_all"]
module.eks.aws_security_group_rule.node["ingress_cluster_10251_webhook"]
module.eks.aws_security_group_rule.node["ingress_cluster_443"]
module.eks.aws_security_group_rule.node["ingress_cluster_4443_webhook"]
module.eks.aws_security_group_rule.node["ingress_cluster_6443_webhook"]
module.eks.aws_security_group_rule.node["ingress_cluster_8443_webhook"]
module.eks.aws_security_group_rule.node["ingress_cluster_9443_webhook"]
module.eks.aws_security_group_rule.node["ingress_cluster_kubelet"]
module.eks.aws_security_group_rule.node["ingress_nodes_ephemeral"]
module.eks.aws_security_group_rule.node["ingress_self_coredns_tcp"]
module.eks.aws_security_group_rule.node["ingress_self_coredns_udp"]
module.eks.time_sleep.this[0]
module.vpc.aws_default_network_acl.this[0]
module.vpc.aws_default_route_table.default[0]
module.vpc.aws_default_security_group.this[0]
module.vpc.aws_eip.nat[0]
module.vpc.aws_internet_gateway.this[0]
module.vpc.aws_nat_gateway.this[0]
module.vpc.aws_route.private_nat_gateway[0]
module.vpc.aws_route.public_internet_gateway[0]
module.vpc.aws_route_table.private[0]
module.vpc.aws_route_table.public[0]
module.vpc.aws_route_table_association.private[0]
module.vpc.aws_route_table_association.private[1]
module.vpc.aws_route_table_association.public[0]
module.vpc.aws_route_table_association.public[1]
module.vpc.aws_subnet.private[0]
module.vpc.aws_subnet.private[1]
module.vpc.aws_subnet.public[0]
module.vpc.aws_subnet.public[1]
module.vpc.aws_vpc.this[0]
module.eks.module.kms.data.aws_caller_identity.current[0]
module.eks.module.kms.data.aws_iam_policy_document.this[0]
module.eks.module.kms.data.aws_partition.current[0]
module.eks.module.kms.aws_kms_alias.this["cluster"]
module.eks.module.kms.aws_kms_key.this[0]