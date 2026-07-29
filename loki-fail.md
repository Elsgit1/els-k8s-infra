$ kget ns
NAME              STATUS   AGE
default           Active   3d
ingress-nginx     Active   2d22h
karpenter         Active   19h
kube-node-lease   Active   3d
kube-public       Active   3d
kube-system       Active   3d
observability     Active   19h
test              Active   20h
(.venv)
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (fix2)
$ kget-a -n observability
NAME                    READY   STATUS    RESTARTS   AGE
pod/loki-0              0/2     Pending   0          19h
pod/loki-canary-8phz4   1/1     Running   0          19h
pod/loki-canary-bmnth   1/1     Running   0          19h

NAME                         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)              AGE
service/loki                 ClusterIP   172.20.88.90    <none>        3100/TCP,9095/TCP    19h
service/loki-canary          ClusterIP   172.20.241.92   <none>        3500/TCP             19h
service/loki-chunks-cache    ClusterIP   None            <none>        11211/TCP,9150/TCP   19h
service/loki-headless        ClusterIP   None            <none>        3100/TCP             19h
service/loki-memberlist      ClusterIP   None            <none>        7946/TCP             19h
service/loki-results-cache   ClusterIP   None            <none>        11211/TCP,9150/TCP   19h

NAME                         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/loki-canary   2         2         2       2            2           <none>          19h

NAME                                  READY   AGE
statefulset.apps/loki                 0/1     19h
statefulset.apps/loki-chunks-cache    0/0     19h
statefulset.apps/loki-results-cache   0/0     19h
(.venv)
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (fix2)
$ kdesc pod/loki-0 -n observability
Name:             loki-0
Namespace:        observability
Priority:         0
Service Account:  loki
Node:             <none>
Labels:           app.kubernetes.io/component=single-binary
                  app.kubernetes.io/instance=loki
                  app.kubernetes.io/name=loki
                  app.kubernetes.io/part-of=memberlist
                  apps.kubernetes.io/pod-index=0
                  controller-revision-hash=loki-699b7bc49c
                  statefulset.kubernetes.io/pod-name=loki-0
Annotations:      checksum/config: 514338b48e9614fbdc527d57efaedbec9c97332422817539a32e0ebaf4f84574
                  kubectl.kubernetes.io/default-container: loki
                  storage/size: 20Gi
Status:           Pending
IP:
IPs:              <none>
Controlled By:    StatefulSet/loki
Containers:
  loki:
    Image:       docker.io/grafana/loki:3.6.8
    Ports:       3100/TCP, 9095/TCP, 7946/TCP
    Host Ports:  0/TCP, 0/TCP, 0/TCP
    Args:
      -config.file=/etc/loki/config/config.yaml
      -target=all
    Readiness:    http-get http://:http-metrics/ready delay=15s timeout=1s period=10s #success=1 #failure=3
    Environment:  <none>
    Mounts:
      /etc/loki/config from config (rw)
      /etc/loki/runtime-config from runtime-config (rw)
      /rules from sc-rules-volume (rw)
      /tmp from tmp (rw)
      /var/loki from storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mdp9z (ro)
  loki-sc-rules:
    Image:      docker.io/kiwigrid/k8s-sidecar:2.5.0
    Port:       <none>
    Host Port:  <none>
    Environment:
      METHOD:                WATCH
      LABEL:                 loki_rule
      FOLDER:                /rules
      RESOURCE:              both
      WATCH_SERVER_TIMEOUT:  60
      WATCH_CLIENT_TIMEOUT:  60
      LOG_LEVEL:             INFO
    Mounts:
      /rules from sc-rules-volume (rw)
      /tmp from tmp (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mdp9z (ro)
Conditions:
  Type           Status
  PodScheduled   False
Volumes:
  storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  storage-loki-0
    ReadOnly:   false
  tmp:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      loki
    Optional:  false
  runtime-config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      loki-runtime
    Optional:  false
  sc-rules-volume:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  kube-api-access-mdp9z:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              role=addons
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  92s (x235 over 19h)  default-scheduler  0/2 nodes are available: pod has unbound immediate PersistentVolumeClaims. not found
  Warning  FailedScheduling  76s (x234 over 19h)  karpenter          Failed to schedule pod, unbound pvc must define a storage class (PersistentVolumeClaim=observability/storage-loki-0, StorageClass=)
(.venv)
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (fix2)
$ kget sc
NAME                     PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
ebs-gp3-karpenter-test   ebs.csi.aws.com         Delete          WaitForFirstConsumer   true                   20h
gp2                      kubernetes.io/aws-ebs   Delete          WaitForFirstConsumer   false                  3d
