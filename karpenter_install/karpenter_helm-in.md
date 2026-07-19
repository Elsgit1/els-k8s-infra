1. Export terraform outputs as environment variables which will be passed to karpenter_values.yml file:
    export CLUSTER_NAME=$(terraform output -raw eks_cluster_name)
    export CLUSTER_ENDPOINT=$(terraform output -raw eks_cluster_endpoint)
    export KARPENTER_ROLE_ARN=$(terraform output -raw karpenter_role_arn)
    export PRIVATE_SUBNETS=$(terraform output -json private_subnets | sed -n 's/.*"\([^"]*\)".*/\1/p')
    export SECURITY_GROUP_ID=$(terraform output -raw eks_node_sg)
    export INSTANCE_PROFILE=$(terraform output -raw karpenter_instance_profile)
    export CLUSTER_CA_CERTIFICATE=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')
    export INTERRUPTION_QUEUE=$(terraform output -raw karpenter_interruption_queue)


2. Create `karpenter` namespace, and a secret named `karpenter-webhook-cert` with the webhook_cert.yml file:
     kubectl apply -f webhook_cert.yml
     

3. Add chart and install karpenter using helm while using karpenter_values.yml file to customize the installation:
    helm repo add karpenter https://charts.karpenter.sh
    helm repo update

    helm install karpenter karpenter/karpenter --values ./karpenter_values.yml --namespace karpenter \
    --set controller.clusterName=$(terraform output -raw eks_cluster_name) \
    --set controller.clusterEndpoint=$(terraform output -raw eks_cluster_endpoint) \
    --set controller.defaultSubnet=$(terraform output -json private_subnets | sed -n 's/.*"\([^"]*\)".*/\1/p') \
    --set controller.defaultSecurityGroup=$(terraform output -raw eks_node_sg) \
    --set controller.defaultInstanceProfile=$(terraform output -raw karpenter_instance_profile) \
    --set controller.interruptionQueue=$(terraform output -raw karpenter_interruption_queue) \
    --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=$(terraform output -raw karpenter_role_arn) \
    --set controller.clusterCaCertificate=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.certificate-authority-data}') \
    --set controller.env[0].name=CLUSTER_NAME \
    --set controller.env[0].value=$(terraform output -raw eks_cluster_name) \
    --set controller.env[1].name=CLUSTER_ENDPOINT \
    --set controller.env[1].value=$(terraform output -raw eks_cluster_endpoint) \
    --set controller.env[2].name=AWS_REGION \
    --set controller.env[2].value=us-west-1


4. Install karpenter CRDs:
    kubectl apply -f \
    "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v1.0.3/pkg/apis/crds/karpenter.sh_nodepools.yaml"
    kubectl apply -f \
    "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v1.0.3/pkg/apis/crds/karpenter.k8s.aws_ec2nodeclasses.yaml"
    kubectl apply -f \
    "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v1.0.3/pkg/apis/crds/karpenter.sh_nodeclaims.yaml"
    

5. Create karpenter nodepool and pod disruption budget:
    kubectl apply -f nodepool.yml -f pod_disruption_budget.yml



    Using the command below, you can later on upgrade/update the helm installation if u updated values in values file:
      helm upgrade karpenter karpenter/karpenter --values ./karpenter_values.yml -n karpenter \

    Command to verify your current helm values: 
      helm get values karpenter -n karpenter

    Command to restart deployment after making changes:
      kubectl rollout restart deployment karpenter -n karpenter
    
    Verify that karpenter is actually provisioning nodes, or see any issues causing it not to:
      kubectl logs -n karpenter -l app.kubernetes.io/name=karpenter

    Pods can be deleted so they're receated using below comand:
      kubectl delete pod -l app.kubernetes.io/name=karpenter -n karpenter
    
    View deployment config:
      kubectl get deployment karpenter -n karpenter -o yaml
    
    Copy deployment config into a new YAML file so can edit on IDE:
      kubectl get deployment karpenter -n karpenter -o yaml>deployment.yml

    Edit deployment:
      kubectl edit deployment karpenter -n karpenter
    
    Describe events in a pod or a deployment:
      kubectl describe {pod-name} -n {namspace} 
      kubectl describe {deployment-name} -n {namspace}
      kubectl get events -n {namspace}	  

    View pod logs to diagnose exact cause of issues:
      kubectl logs {pod-name} -n {namspace} 



