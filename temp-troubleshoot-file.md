$ kget ns
NAME              STATUS   AGE
default           Active   22h
ingress-nginx     Active   10h
kube-node-lease   Active   22h
kube-public       Active   22h
kube-system       Active   22h
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore1)
$ h ls -A
NAME    NAMESPACE       REVISION        UPDATED STATUS  CHART   APP VERSION
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore1)
$ kget-a -n ingress-nginx
No resources found in ingress-nginx namespace.
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore1)
$ kget-a -n kube-system
NAME                                     READY   STATUS    RESTARTS   AGE
pod/aws-node-5q4lm                       2/2     Running   0          22h
pod/aws-node-c5lvx                       0/2     Pending   0          8h
pod/aws-node-v7skb                       2/2     Running   0          22h
pod/aws-node-wvmc5                       2/2     Running   0          22h
pod/coredns-5554697bb6-6nrwj             1/1     Running   0          22h
pod/coredns-5554697bb6-kftgp             1/1     Running   0          22h
pod/ebs-csi-controller-94677cd59-dtnrv   6/6     Running   0          18h
pod/ebs-csi-controller-94677cd59-ls8gr   6/6     Running   0          18h
pod/ebs-csi-node-b5q9z                   3/3     Running   0          18h
pod/ebs-csi-node-dltwv                   3/3     Running   0          18h
pod/ebs-csi-node-r4hrj                   0/3     Pending   0          8h
pod/ebs-csi-node-zt466                   3/3     Running   0          18h
pod/eks-pod-identity-agent-cptsw         1/1     Running   0          22h
pod/eks-pod-identity-agent-crcjt         1/1     Running   0          22h
pod/eks-pod-identity-agent-nwfzb         1/1     Running   0          22h
pod/eks-pod-identity-agent-pwxpb         0/1     Pending   0          8h
pod/kube-proxy-5cbvw                     1/1     Running   0          22h
pod/kube-proxy-7462z                     1/1     Running   0          22h
pod/kube-proxy-847fc                     1/1     Running   0          22h
pod/kube-proxy-k4gkm                     0/1     Pending   0          8h

NAME                                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                        AGE
service/eks-extension-metrics-api       ClusterIP   172.20.100.56   <none>        443/TCP                        22h
service/kube-dns                        ClusterIP   172.20.0.10     <none>        53/UDP,53/TCP,9153/TCP         22h
service/kube-prometheus-stack-kubelet   ClusterIP   None            <none>        10250/TCP,4194/TCP,10255/TCP   10h

NAME                                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR              AGE
daemonset.apps/aws-node                 4         4         3       4            3           <none>                     22h
daemonset.apps/ebs-csi-node             4         4         3       4            3           kubernetes.io/os=linux     18h
daemonset.apps/ebs-csi-node-windows     0         0         0       0            0           kubernetes.io/os=windows   18h
daemonset.apps/eks-pod-identity-agent   4         4         3       4            3           <none>                     22h
daemonset.apps/kube-proxy               4         4         3       4            3           <none>                     22h

NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/coredns              2/2     2            2           22h
deployment.apps/ebs-csi-controller   2/2     2            2           18h

NAME                                           DESIRED   CURRENT   READY   AGE
replicaset.apps/coredns-5554697bb6             2         2         2       22h
replicaset.apps/ebs-csi-controller-94677cd59   2         2         2       18h
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore1)
$ kget-a -n kube-public
No resources found in kube-public namespace.
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore1)
$ kget nodeclaim
NAME         TYPE       CAPACITY   ZONE         NODE                                       READY   AGE
apps-p6g29   t3.small   spot       us-west-1a   ip-10-0-1-144.us-west-1.compute.internal   True    8h
(.venv) 