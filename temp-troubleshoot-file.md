$ kget-a -n observability
NAME                                                            READY   STATUS    RESTARTS   AGE
pod/alertmanager-kube-prometheus-stack-alertmanager-0           2/2     Running   0          40m
pod/kube-prometheus-stack-grafana-6b5b955c6-kbk42               0/3     Pending   0          2d17h
pod/kube-prometheus-stack-kube-state-metrics-6f664bc8c4-vq7gv   1/1     Running   0          40m
pod/kube-prometheus-stack-operator-867dc49594-7bk2p             1/1     Running   0          37m
pod/kube-prometheus-stack-prometheus-node-exporter-chjll        1/1     Running   0          33m
pod/kube-prometheus-stack-prometheus-node-exporter-dwkbt        1/1     Running   0          41m
pod/kube-prometheus-stack-prometheus-node-exporter-hlrc2        1/1     Running   0          33m
pod/kube-prometheus-stack-prometheus-node-exporter-qfh2g        1/1     Running   0          41m
pod/loki-0                                                      2/2     Running   0          37m
pod/loki-canary-7shdm                                           1/1     Running   0          33m
pod/loki-canary-9q5ph                                           1/1     Running   0          41m
pod/loki-canary-bj2zq                                           1/1     Running   0          33m
pod/loki-canary-mhm4p                                           1/1     Running   0          41m
pod/prometheus-kube-prometheus-stack-prometheus-0               2/2     Running   0          2d17h
pod/promtail-7d4n8                                              1/1     Running   0          32m
pod/promtail-8pnrm                                              0/1     Pending   0          32m
pod/promtail-bsxzd                                              1/1     Running   0          32m
pod/promtail-t5kr5                                              0/1     Pending   0          32m

NAME                                                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
service/alertmanager-operated                            ClusterIP   None            <none>        9093/TCP,9094/TCP,9094/UDP   2d17h
service/kube-prometheus-stack-alertmanager               ClusterIP   172.20.35.45    <none>        9093/TCP,8080/TCP            2d17h
service/kube-prometheus-stack-grafana                    ClusterIP   172.20.244.70   <none>        80/TCP                       2d17h
service/kube-prometheus-stack-kube-state-metrics         ClusterIP   172.20.25.85    <none>        8080/TCP                     2d17h
service/kube-prometheus-stack-operator                   ClusterIP   172.20.98.98    <none>        443/TCP                      2d17h
service/kube-prometheus-stack-prometheus                 ClusterIP   172.20.80.9     <none>        9090/TCP,8080/TCP            2d17h
service/kube-prometheus-stack-prometheus-node-exporter   ClusterIP   172.20.54.104   <none>        9100/TCP                     2d17h
service/loki                                             ClusterIP   172.20.21.36    <none>        3100/TCP,9095/TCP            2d17h
service/loki-canary                                      ClusterIP   172.20.86.181   <none>        3500/TCP                     2d17h
service/loki-chunks-cache                                ClusterIP   None            <none>        11211/TCP,9150/TCP           2d17h
service/loki-headless                                    ClusterIP   None            <none>        3100/TCP                     2d17h
service/loki-memberlist                                  ClusterIP   None            <none>        7946/TCP                     2d17h
service/loki-results-cache                               ClusterIP   None            <none>        11211/TCP,9150/TCP           2d17h
service/prometheus-operated                              ClusterIP   None            <none>        9090/TCP                     2d17h
service/promtail-metrics                                 ClusterIP   None            <none>        3101/TCP                     32m

NAME                                                            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-prometheus-stack-prometheus-node-exporter   4         4         4       4            4           kubernetes.io/os=linux   2d17h
daemonset.apps/loki-canary                                      4         4         4       4            4           <none>                   2d17h
daemonset.apps/promtail                                         4         4         2       4            2           <none>                   32m

NAME                                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kube-prometheus-stack-grafana              0/1     1            0           2d17h
deployment.apps/kube-prometheus-stack-kube-state-metrics   1/1     1            1           2d17h
deployment.apps/kube-prometheus-stack-operator             1/1     1            1           2d17h

NAME                                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/kube-prometheus-stack-grafana-6b5b955c6               1         1         0       2d17h
replicaset.apps/kube-prometheus-stack-kube-state-metrics-6f664bc8c4   1         1         1       2d17h
replicaset.apps/kube-prometheus-stack-operator-867dc49594             1         1         1       2d17h

NAME                                                               READY   AGE
statefulset.apps/alertmanager-kube-prometheus-stack-alertmanager   1/1     2d17h
statefulset.apps/loki                                              1/1     2d17h
statefulset.apps/loki-chunks-cache                                 0/0     2d17h
statefulset.apps/loki-results-cache                                0/0     2d17h
statefulset.apps/prometheus-kube-prometheus-stack-prometheus       1/1     2d17h
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (fix)
$ kdesc ^Cn observability
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (fix)
$ kdesc pod/kube-prometheus-stack-grafana-6b5b955c6-kbk42 -n observability
Name:             kube-prometheus-stack-grafana-6b5b955c6-kbk42
Namespace:        observability
Priority:         0
Service Account:  kube-prometheus-stack-grafana
Node:             <none>
Labels:           app.kubernetes.io/instance=kube-prometheus-stack
                  app.kubernetes.io/name=grafana
                  app.kubernetes.io/version=13.1.1
                  helm.sh/chart=grafana-12.9.0
                  pod-template-hash=6b5b955c6
Annotations:      checksum/config: 5bceeca3808849664f09f642547ce17fdf495522238ef9ce952b20cfa36b7de5
                  checksum/sc-dashboard-provider-config: e70bf6a851099d385178a76de9757bb0bef8299da6d8443602590e44f05fdf24
                  checksum/secret: f49d925732f39b486cfb692fbef5051c0cd3f4dae64646e862c0a9bf98dd05bb
                  kubectl.kubernetes.io/default-container: grafana
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    ReplicaSet/kube-prometheus-stack-grafana-6b5b955c6
Init Containers:
  init-chown-data:
    Image:           docker.io/library/busybox:1.38.0
    Port:            <none>
    Host Port:       <none>
    SeccompProfile:  RuntimeDefault
    Command:
      chown
      -R
      472:472
      /var/lib/grafana
    Environment:  <none>
    Mounts:
      /var/lib/grafana from storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zwpn6 (ro)
Containers:
  grafana-sc-dashboard:
    Image:           quay.io/kiwigrid/k8s-sidecar:2.9.0
    Port:            <none>
    Host Port:       <none>
    SeccompProfile:  RuntimeDefault
    Environment:
      METHOD:        WATCH
      LABEL:         grafana_dashboard
      LABEL_VALUE:   1
      FOLDER:        /tmp/dashboards
      RESOURCE:      both
      NAMESPACE:     ALL
      REQ_USERNAME:  <set to the key 'admin-user' in secret 'kube-prometheus-stack-grafana'>      Optional: false
      REQ_PASSWORD:  <set to the key 'admin-password' in secret 'kube-prometheus-stack-grafana'>  Optional: false
      REQ_URL:       http://localhost:3000/api/admin/provisioning/dashboards/reload
      REQ_METHOD:    POST
    Mounts:
      /tmp/dashboards from sc-dashboard-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zwpn6 (ro)
  grafana-sc-datasources:
    Image:           quay.io/kiwigrid/k8s-sidecar:2.9.0
    Port:            <none>
    Host Port:       <none>
    SeccompProfile:  RuntimeDefault
    Environment:
      METHOD:        WATCH
      LABEL:         grafana_datasource
      LABEL_VALUE:   1
      FOLDER:        /etc/grafana/provisioning/datasources
      RESOURCE:      both
      REQ_USERNAME:  <set to the key 'admin-user' in secret 'kube-prometheus-stack-grafana'>      Optional: false
      REQ_PASSWORD:  <set to the key 'admin-password' in secret 'kube-prometheus-stack-grafana'>  Optional: false
      REQ_URL:       http://localhost:3000/api/admin/provisioning/datasources/reload
      REQ_METHOD:    POST
    Mounts:
      /etc/grafana/provisioning/datasources from sc-datasources-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zwpn6 (ro)
  grafana:
    Image:           docker.io/grafana/grafana:13.1.1
    Ports:           3000/TCP, 9094/TCP, 9094/UDP, 6060/TCP
    Host Ports:      0/TCP, 0/TCP, 0/UDP, 0/TCP
    SeccompProfile:  RuntimeDefault
    Liveness:        http-get http://:grafana/api/health delay=60s timeout=30s period=10s #success=1 #failure=10
    Readiness:       http-get http://:grafana/api/health delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:
      POD_IP:                          (v1:status.podIP)
      GF_SECURITY_ADMIN_USER:         <set to the key 'admin-user' in secret 'kube-prometheus-stack-grafana'>      Optional: false
      GF_SECURITY_ADMIN_PASSWORD:     <set to the key 'admin-password' in secret 'kube-prometheus-stack-grafana'>  Optional: false
      GF_PATHS_DATA:                  /var/lib/grafana/
      GF_PATHS_LOGS:                  /var/log/grafana
      GF_PATHS_PLUGINS:               /var/lib/grafana/plugins
      GF_PATHS_PROVISIONING:          /etc/grafana/provisioning
      GF_UNIFIED_STORAGE_INDEX_PATH:  /var/lib/grafana-search/bleve
    Mounts:
      /etc/grafana/grafana.ini from config (rw,path="grafana.ini")
      /etc/grafana/provisioning/dashboards/sc-dashboardproviders.yaml from sc-dashboard-provider (rw,path="provider.yaml")
      /etc/grafana/provisioning/datasources from sc-datasources-volume (rw)
      /tmp/dashboards from sc-dashboard-volume (rw)
      /var/lib/grafana from storage (rw)
      /var/lib/grafana-search from search (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zwpn6 (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      kube-prometheus-stack-grafana
    Optional:  false
  storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  kube-prometheus-stack-grafana
    ReadOnly:   false
  search:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  sc-dashboard-volume:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  sc-dashboard-provider:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      kube-prometheus-stack-grafana-config-dashboards
    Optional:  false
  sc-datasources-volume:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-zwpn6:
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
  Type     Reason            Age                    From               Message
  ----     ------            ----                   ----               -------
  Warning  FailedScheduling  45m (x769 over 2d16h)  karpenter          Failed to schedule pod, getting persistent volume claim, PersistentVolumeClaim "kube-prometheus-stack-grafana" not found (PersistentVolumeClaim=kube-prometheus-stack-grafana)
  Warning  FailedScheduling  42m                    karpenter          Failed to schedule pod, getting persistent volume claim, PersistentVolumeClaim "kube-prometheus-stack-grafana" not found (PersistentVolumeClaim=kube-prometheus-stack-grafana)
  Warning  FailedScheduling  42m (x14 over 44m)     default-scheduler  0/5 nodes are available: persistentvolumeclaim "kube-prometheus-stack-grafana" not found. not found
  Warning  FailedScheduling  36m (x771 over 2d16h)  default-scheduler  0/3 nodes are available: persistentvolumeclaim "kube-prometheus-stack-grafana" not found. not found
  Warning  FailedScheduling  4m40s (x8 over 39m)    karpenter          Failed to schedule pod, getting persistent volume claim, PersistentVolumeClaim "kube-prometheus-stack-grafana" not found (PersistentVolumeClaim=kube-prometheus-stack-grafana)
  Warning  FailedScheduling  40s (x31 over 17h)     default-scheduler  0/4 nodes are available: persistentvolumeclaim "kube-prometheus-stack-grafana" not found. not found
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (fix)
$ kdesc pod/promtail-8pnrm -n observability
Name:             promtail-8pnrm
Namespace:        observability
Priority:         0
Service Account:  promtail
Node:             <none>
Labels:           app.kubernetes.io/instance=promtail
                  app.kubernetes.io/name=promtail
                  controller-revision-hash=59586f978
                  pod-template-generation=1
Annotations:      checksum/config: 0f49fcd7a8fab642f9644e0a4d67b9f2bf9ce3e2cbf1f2ebfa7a301dbd59a7e0
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    DaemonSet/promtail
Containers:
  promtail:
    Image:      docker.io/grafana/promtail:3.5.1
    Port:       3101/TCP
    Host Port:  0/TCP
    Args:
      -config.file=/etc/promtail/promtail.yaml
    Readiness:  http-get http://:http-metrics/ready delay=10s timeout=1s period=10s #success=1 #failure=5
    Environment:
      HOSTNAME:   (v1:spec.nodeName)
    Mounts:
      /etc/promtail from config (rw)
      /run/promtail from run (rw)
      /var/lib/docker/containers from containers (ro)
      /var/log/pods from pods (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-bq5df (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  config:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  promtail
    Optional:    false
  run:
    Type:          HostPath (bare host directory volume)
    Path:          /run/promtail
    HostPathType:  
  containers:
    Type:          HostPath (bare host directory volume)
    Path:          /var/lib/docker/containers
    HostPathType:  
  pods:
    Type:          HostPath (bare host directory volume)
    Path:          /var/log/pods
    HostPathType:  
  kube-api-access-bq5df:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node-role.kubernetes.io/control-plane:NoSchedule op=Exists
                             node-role.kubernetes.io/master:NoSchedule op=Exists
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Events:
  Type     Reason            Age                From               Message
  ----     ------            ----               ----               -------
  Warning  FailedScheduling  99s (x8 over 36m)  default-scheduler  0/4 nodes are available: 1 Too many pods, 3 node(s) didn't satisfy plugin(s) [NodeAffinity]. no new claims to deallocate, preemption: 0/4 nodes are available: 1 No preemption victims found for incoming pod, 3 Preemption is not helpful for scheduling.
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (fix)
$ kdesc pod/promtail-t5kr5 -n observability
Name:             promtail-t5kr5
Namespace:        observability
Priority:         0
Service Account:  promtail
Node:             <none>
Labels:           app.kubernetes.io/instance=promtail
                  app.kubernetes.io/name=promtail
                  controller-revision-hash=59586f978
                  pod-template-generation=1
Annotations:      checksum/config: 0f49fcd7a8fab642f9644e0a4d67b9f2bf9ce3e2cbf1f2ebfa7a301dbd59a7e0
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    DaemonSet/promtail
Containers:
  promtail:
    Image:      docker.io/grafana/promtail:3.5.1
    Port:       3101/TCP
    Host Port:  0/TCP
    Args:
      -config.file=/etc/promtail/promtail.yaml
    Readiness:  http-get http://:http-metrics/ready delay=10s timeout=1s period=10s #success=1 #failure=5
    Environment:
      HOSTNAME:   (v1:spec.nodeName)
    Mounts:
      /etc/promtail from config (rw)
      /run/promtail from run (rw)
      /var/lib/docker/containers from containers (ro)
      /var/log/pods from pods (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zl5pm (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  config:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  promtail
    Optional:    false
  run:
    Type:          HostPath (bare host directory volume)
    Path:          /run/promtail
    HostPathType:  
  containers:
    Type:          HostPath (bare host directory volume)
    Path:          /var/lib/docker/containers
    HostPathType:  
  pods:
    Type:          HostPath (bare host directory volume)
    Path:          /var/log/pods
    HostPathType:  
  kube-api-access-zl5pm:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node-role.kubernetes.io/control-plane:NoSchedule op=Exists
                             node-role.kubernetes.io/master:NoSchedule op=Exists
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  2m53s (x8 over 38m)  default-scheduler  0/4 nodes are available: 1 Too many pods, 3 node(s) didn't satisfy plugin(s) [NodeAffinity]. no new claims to deallocate, preemption: 0/4 nodes are available: 1 No preemption victims found for incoming pod, 3 Preemption is not helpful for scheduling.