## Will use this file to temporarily store error logs

Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore)
$ kget-a -n observability
NAME                                                            READY   STATUS    RESTARTS   AGE
pod/alertmanager-kube-prometheus-stack-alertmanager-0           0/2     Pending   0          3m20s
pod/kube-prometheus-stack-grafana-6b5b955c6-kbk42               0/3     Pending   0          3m26s
pod/kube-prometheus-stack-kube-state-metrics-6f664bc8c4-z4pbw   1/1     Running   0          3m26s
pod/kube-prometheus-stack-operator-867dc49594-pkhkb             1/1     Running   0          3m26s
pod/kube-prometheus-stack-prometheus-node-exporter-59hsf        1/1     Running   0          3m26s
pod/kube-prometheus-stack-prometheus-node-exporter-mj76t        1/1     Running   0          3m26s
pod/kube-prometheus-stack-prometheus-node-exporter-xhrvv        1/1     Running   0          3m27s
pod/loki-0                                                      2/2     Running   0          5m11s
pod/loki-canary-7chx4                                           1/1     Running   0          5m11s
pod/loki-canary-9k2mg                                           1/1     Running   0          4m36s
pod/loki-canary-qv24b                                           1/1     Running   0          5m11s
pod/prometheus-kube-prometheus-stack-prometheus-0               0/2     Pending   0          3m20s

NAME                                                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
service/alertmanager-operated                            ClusterIP   None            <none>        9093/TCP,9094/TCP,9094/UDP   3m20s
service/kube-prometheus-stack-alertmanager               ClusterIP   172.20.35.45    <none>        9093/TCP,8080/TCP            3m27s
service/kube-prometheus-stack-grafana                    ClusterIP   172.20.244.70   <none>        80/TCP                       3m27s
service/kube-prometheus-stack-kube-state-metrics         ClusterIP   172.20.25.85    <none>        8080/TCP                     3m27s
service/kube-prometheus-stack-operator                   ClusterIP   172.20.98.98    <none>        443/TCP                      3m27s
service/kube-prometheus-stack-prometheus                 ClusterIP   172.20.80.9     <none>        9090/TCP,8080/TCP            3m27s
service/kube-prometheus-stack-prometheus-node-exporter   ClusterIP   172.20.54.104   <none>        9100/TCP                     3m27s
service/loki                                             ClusterIP   172.20.21.36    <none>        3100/TCP,9095/TCP            5m11s
service/loki-canary                                      ClusterIP   172.20.86.181   <none>        3500/TCP                     5m11s
service/loki-chunks-cache                                ClusterIP   None            <none>        11211/TCP,9150/TCP           5m11s
service/loki-headless                                    ClusterIP   None            <none>        3100/TCP                     5m11s
service/loki-memberlist                                  ClusterIP   None            <none>        7946/TCP                     5m11s
service/loki-results-cache                               ClusterIP   None            <none>        11211/TCP,9150/TCP           5m11s
service/prometheus-operated                              ClusterIP   None            <none>        9090/TCP                     3m20s

NAME                                                            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-prometheus-stack-prometheus-node-exporter   3         3         3       3            3           kubernetes.io/os=linux   3m27s
daemonset.apps/loki-canary                                      3         3         3       3            3           <none>                   5m11s

NAME                                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kube-prometheus-stack-grafana              0/1     1            0           3m27s
deployment.apps/kube-prometheus-stack-kube-state-metrics   1/1     1            1           3m27s
deployment.apps/kube-prometheus-stack-operator             1/1     1            1           3m27s

NAME                                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/kube-prometheus-stack-grafana-6b5b955c6               1         1         0       3m26s
replicaset.apps/kube-prometheus-stack-kube-state-metrics-6f664bc8c4   1         1         1       3m26s
replicaset.apps/kube-prometheus-stack-operator-867dc49594             1         1         1       3m26s

NAME                                                               READY   AGE
statefulset.apps/alertmanager-kube-prometheus-stack-alertmanager   0/1     3m20s
statefulset.apps/loki                                              1/1     5m11s
statefulset.apps/loki-chunks-cache                                 0/0     5m11s
statefulset.apps/loki-results-cache                                0/0     5m11s
statefulset.apps/prometheus-kube-prometheus-stack-prometheus       0/1     3m20s
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore)
$ kget-a -n observability
NAME                                                            READY   STATUS    RESTARTS   AGE
pod/alertmanager-kube-prometheus-stack-alertmanager-0           0/2     Pending   0          4m34s
pod/kube-prometheus-stack-grafana-6b5b955c6-kbk42               0/3     Pending   0          4m40s
pod/kube-prometheus-stack-kube-state-metrics-6f664bc8c4-z4pbw   1/1     Running   0          4m40s
pod/kube-prometheus-stack-operator-867dc49594-pkhkb             1/1     Running   0          4m40s
pod/kube-prometheus-stack-prometheus-node-exporter-59hsf        1/1     Running   0          4m40s
pod/kube-prometheus-stack-prometheus-node-exporter-mj76t        1/1     Running   0          4m40s
pod/kube-prometheus-stack-prometheus-node-exporter-xhrvv        1/1     Running   0          4m41s
pod/loki-0                                                      2/2     Running   0          6m25s
pod/loki-canary-7chx4                                           1/1     Running   0          6m25s
pod/loki-canary-9k2mg                                           1/1     Running   0          5m50s
pod/loki-canary-qv24b                                           1/1     Running   0          6m25s
pod/prometheus-kube-prometheus-stack-prometheus-0               0/2     Pending   0          4m34s

NAME                                                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
service/alertmanager-operated                            ClusterIP   None            <none>        9093/TCP,9094/TCP,9094/UDP   4m35s
service/kube-prometheus-stack-alertmanager               ClusterIP   172.20.35.45    <none>        9093/TCP,8080/TCP            4m42s
service/kube-prometheus-stack-grafana                    ClusterIP   172.20.244.70   <none>        80/TCP                       4m42s
service/kube-prometheus-stack-kube-state-metrics         ClusterIP   172.20.25.85    <none>        8080/TCP                     4m42s
service/kube-prometheus-stack-operator                   ClusterIP   172.20.98.98    <none>        443/TCP                      4m42s
service/kube-prometheus-stack-prometheus                 ClusterIP   172.20.80.9     <none>        9090/TCP,8080/TCP            4m42s
service/kube-prometheus-stack-prometheus-node-exporter   ClusterIP   172.20.54.104   <none>        9100/TCP                     4m42s
service/loki                                             ClusterIP   172.20.21.36    <none>        3100/TCP,9095/TCP            6m26s
service/loki-canary                                      ClusterIP   172.20.86.181   <none>        3500/TCP                     6m26s
service/loki-chunks-cache                                ClusterIP   None            <none>        11211/TCP,9150/TCP           6m26s
service/loki-headless                                    ClusterIP   None            <none>        3100/TCP                     6m26s
service/loki-memberlist                                  ClusterIP   None            <none>        7946/TCP                     6m26s
service/loki-results-cache                               ClusterIP   None            <none>        11211/TCP,9150/TCP           6m26s
service/prometheus-operated                              ClusterIP   None            <none>        9090/TCP                     4m35s

NAME                                                            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-prometheus-stack-prometheus-node-exporter   3         3         3       3            3           kubernetes.io/os=linux   4m42s
daemonset.apps/loki-canary                                      3         3         3       3            3           <none>                   6m26s

NAME                                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kube-prometheus-stack-grafana              0/1     1            0           4m42s
deployment.apps/kube-prometheus-stack-kube-state-metrics   1/1     1            1           4m42s
deployment.apps/kube-prometheus-stack-operator             1/1     1            1           4m42s

NAME                                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/kube-prometheus-stack-grafana-6b5b955c6               1         1         0       4m41s
replicaset.apps/kube-prometheus-stack-kube-state-metrics-6f664bc8c4   1         1         1       4m41s
replicaset.apps/kube-prometheus-stack-operator-867dc49594             1         1         1       4m41s

NAME                                                               READY   AGE
statefulset.apps/alertmanager-kube-prometheus-stack-alertmanager   0/1     4m35s
statefulset.apps/loki                                              1/1     6m26s
statefulset.apps/loki-chunks-cache                                 0/0     6m26s
statefulset.apps/loki-results-cache                                0/0     6m26s
statefulset.apps/prometheus-kube-prometheus-stack-prometheus       0/1     4m35s
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore)
$ kdesc pod/prometheus-kube-prometheus-stack-prometheus-0 -n observability
Name:             prometheus-kube-prometheus-stack-prometheus-0
Namespace:        observability
Priority:         0
Service Account:  kube-prometheus-stack-prometheus
Node:             <none>
Labels:           app.kubernetes.io/instance=kube-prometheus-stack-prometheus
                  app.kubernetes.io/managed-by=prometheus-operator
                  app.kubernetes.io/name=prometheus
                  app.kubernetes.io/version=3.13.1-distroless
                  apps.kubernetes.io/pod-index=0
                  controller-revision-hash=prometheus-kube-prometheus-stack-prometheus-7c95df6b97
                  operator.prometheus.io/name=kube-prometheus-stack-prometheus
                  operator.prometheus.io/shard=0
                  prometheus=kube-prometheus-stack-prometheus
                  statefulset.kubernetes.io/pod-name=prometheus-kube-prometheus-stack-prometheus-0
Annotations:      kubectl.kubernetes.io/default-container: prometheus
Status:           Pending
SeccompProfile:   RuntimeDefault
IP:               
IPs:              <none>
Controlled By:    StatefulSet/prometheus-kube-prometheus-stack-prometheus
Init Containers:
  init-config-reloader:
    Image:      quay.io/prometheus-operator/prometheus-config-reloader:v0.92.1
    Port:       8081/TCP
    Host Port:  0/TCP
    Command:
      /bin/prometheus-config-reloader
    Args:
      --watch-interval=0
      --listen-address=:8081
      --config-file=/etc/prometheus/config/prometheus.yaml.gz
      --config-envsubst-file=/etc/prometheus/config_out/prometheus.env.yaml
      --watched-dir=/etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-0
      --watched-dir=/etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-1
      --watched-dir=/etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-2
      --watched-dir=/etc/prometheus/config
    Environment:
      POD_NAME:  prometheus-kube-prometheus-stack-prometheus-0 (v1:metadata.name)
      SHARD:     0
    Mounts:
      /etc/prometheus/config from config (rw)
      /etc/prometheus/config_out from config-out (rw)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-0 from prometheus-kube-prometheus-stack-prometheus-rulefiles-0 (rw)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-1 from prometheus-kube-prometheus-stack-prometheus-rulefiles-1 (rw)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-2 from prometheus-kube-prometheus-stack-prometheus-rulefiles-2 (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2qb2v (ro)
Containers:
  prometheus:
    Image:      quay.io/prometheus/prometheus:v3.13.1-distroless
    Port:       9090/TCP
    Host Port:  0/TCP
    Args:
      --config.file=/etc/prometheus/config_out/prometheus.env.yaml
      --web.enable-lifecycle
      --web.external-url=http://kube-prometheus-stack-prometheus.observability:9090
      --web.route-prefix=/
      --storage.tsdb.path=/prometheus
      --storage.tsdb.wal-compression
      --web.config.file=/etc/prometheus/web_config/web-config.yaml
    Liveness:     http-get http://:http-web/-/healthy delay=0s timeout=3s period=5s #success=1 #failure=6
    Readiness:    http-get http://:http-web/-/ready delay=0s timeout=3s period=5s #success=1 #failure=3
    Startup:      http-get http://:http-web/-/ready delay=0s timeout=3s period=15s #success=1 #failure=60
    Environment:  <none>
    Mounts:
      /etc/prometheus/certs from tls-assets (ro)
      /etc/prometheus/config_out from config-out (ro)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-0 from prometheus-kube-prometheus-stack-prometheus-rulefiles-0 (ro)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-1 from prometheus-kube-prometheus-stack-prometheus-rulefiles-1 (ro)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-2 from prometheus-kube-prometheus-stack-prometheus-rulefiles-2 (ro)
      /etc/prometheus/web_config/web-config.yaml from web-config (ro,path="web-config.yaml")
      /prometheus from prometheus-kube-prometheus-stack-prometheus-db (rw,path="prometheus-db")
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2qb2v (ro)
  config-reloader:
    Image:      quay.io/prometheus-operator/prometheus-config-reloader:v0.92.1
    Port:       8080/TCP
    Host Port:  0/TCP
    Command:
      /bin/prometheus-config-reloader
    Args:
      --listen-address=:8080
      --reload-url=http://127.0.0.1:9090/-/reload
      --config-file=/etc/prometheus/config/prometheus.yaml.gz
      --config-envsubst-file=/etc/prometheus/config_out/prometheus.env.yaml
      --watched-dir=/etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-0
      --watched-dir=/etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-1
      --watched-dir=/etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-2
      --watched-dir=/etc/prometheus/config
    Environment:
      POD_NAME:  prometheus-kube-prometheus-stack-prometheus-0 (v1:metadata.name)
      SHARD:     0
    Mounts:
      /etc/prometheus/config from config (rw)
      /etc/prometheus/config_out from config-out (rw)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-0 from prometheus-kube-prometheus-stack-prometheus-rulefiles-0 (rw)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-1 from prometheus-kube-prometheus-stack-prometheus-rulefiles-1 (rw)
      /etc/prometheus/rules/prometheus-kube-prometheus-stack-prometheus-rulefiles-2 from prometheus-kube-prometheus-stack-prometheus-rulefiles-2 (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2qb2v (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  prometheus-kube-prometheus-stack-prometheus-db:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  prometheus-kube-prometheus-stack-prometheus-db-prometheus-kube-prometheus-stack-prometheus-0
    ReadOnly:   false
  config:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  prometheus-kube-prometheus-stack-prometheus
    Optional:    false
  tls-assets:
    Type:                Projected (a volume that contains injected data from multiple sources)
    SecretName:          prometheus-kube-prometheus-stack-prometheus-tls-assets-0
    SecretOptionalName:  <nil>
  config-out:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     Memory
    SizeLimit:  <unset>
  prometheus-kube-prometheus-stack-prometheus-rulefiles-0:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      prometheus-kube-prometheus-stack-prometheus-rulefiles-0
    Optional:  true
  prometheus-kube-prometheus-stack-prometheus-rulefiles-1:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      prometheus-kube-prometheus-stack-prometheus-rulefiles-1
    Optional:  true
  prometheus-kube-prometheus-stack-prometheus-rulefiles-2:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      prometheus-kube-prometheus-stack-prometheus-rulefiles-2
    Optional:  true
  web-config:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  prometheus-kube-prometheus-stack-prometheus-web-config
    Optional:    false
  kube-api-access-2qb2v:
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
  Warning  FailedScheduling  14s (x2 over 5m18s)  default-scheduler  0/3 nodes are available: 1 node(s) didn't match Pod's node affinity/selector, 2 Too many pods. no new claims to deallocate, preemption: 0/3 nodes are available: 1 Preemption is not helpful for scheduling, 2 No preemption victims found for incoming pod.
  Warning  FailedScheduling  13s (x2 over 5m17s)  karpenter          Failed to schedule pod, incompatible requirements, label "role" does not have known values
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore)
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
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  2m2s (x2 over 7m2s)  karpenter          Failed to schedule pod, unbound pvc must define a storage class (PersistentVolumeClaim=observability/kube-prometheus-stack-grafana, StorageClass=)
  Warning  FailedScheduling  113s (x2 over 7m3s)  default-scheduler  0/3 nodes are available: pod has unbound immediate PersistentVolumeClaims. not found
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore)
$ kdesc pod/alertmanager-kube-prometheus-stack-alertmanager-0 -n observability
Name:             alertmanager-kube-prometheus-stack-alertmanager-0
Namespace:        observability
Priority:         0
Service Account:  kube-prometheus-stack-alertmanager
Node:             <none>
Labels:           alertmanager=kube-prometheus-stack-alertmanager
                  app.kubernetes.io/instance=kube-prometheus-stack-alertmanager
                  app.kubernetes.io/managed-by=prometheus-operator
                  app.kubernetes.io/name=alertmanager
                  app.kubernetes.io/version=0.33.1
                  apps.kubernetes.io/pod-index=0
                  controller-revision-hash=alertmanager-kube-prometheus-stack-alertmanager-58686b9548
                  statefulset.kubernetes.io/pod-name=alertmanager-kube-prometheus-stack-alertmanager-0
Annotations:      kubectl.kubernetes.io/default-container: alertmanager
Status:           Pending
SeccompProfile:   RuntimeDefault
IP:               
IPs:              <none>
Controlled By:    StatefulSet/alertmanager-kube-prometheus-stack-alertmanager
Init Containers:
  init-config-reloader:
    Image:      quay.io/prometheus-operator/prometheus-config-reloader:v0.92.1
    Port:       8081/TCP
    Host Port:  0/TCP
    Command:
      /bin/prometheus-config-reloader
    Args:
      --watch-interval=0
      --listen-address=:8081
      --config-file=/etc/alertmanager/config/alertmanager.yaml.gz
      --config-envsubst-file=/etc/alertmanager/config_out/alertmanager.env.yaml
      --watched-dir=/etc/alertmanager/config
    Environment:
      POD_NAME:  alertmanager-kube-prometheus-stack-alertmanager-0 (v1:metadata.name)
      SHARD:     -1
    Mounts:
      /etc/alertmanager/config from config-volume (ro)
      /etc/alertmanager/config_out from config-out (rw)
      /etc/alertmanager/web_config/web-config.yaml from web-config (ro,path="web-config.yaml")
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wdfqf (ro)
Containers:
  alertmanager:
    Image:       quay.io/prometheus/alertmanager:v0.33.1
    Ports:       9093/TCP, 9094/TCP, 9094/UDP
    Host Ports:  0/TCP, 0/TCP, 0/UDP
    Args:
      --config.file=/etc/alertmanager/config_out/alertmanager.env.yaml
      --storage.path=/alertmanager
      --data.retention=120h
      --cluster.listen-address=
      --web.listen-address=:9093
      --web.external-url=http://kube-prometheus-stack-alertmanager.observability:9093
      --web.route-prefix=/
      --cluster.label=observability/kube-prometheus-stack-alertmanager
      --cluster.peer=alertmanager-kube-prometheus-stack-alertmanager-0.alertmanager-operated:9094
      --cluster.reconnect-timeout=5m
      --web.config.file=/etc/alertmanager/web_config/web-config.yaml
    Requests:
      memory:   200Mi
    Liveness:   http-get http://:http-web/-/healthy delay=0s timeout=3s period=10s #success=1 #failure=10
    Readiness:  http-get http://:http-web/-/ready delay=3s timeout=3s period=5s #success=1 #failure=10
    Environment:
      POD_IP:   (v1:status.podIP)
    Mounts:
      /alertmanager from alertmanager-kube-prometheus-stack-alertmanager-db (rw,path="alertmanager-db")
      /etc/alertmanager/certs from tls-assets (ro)
      /etc/alertmanager/cluster_tls_config/cluster-tls-config.yaml from cluster-tls-config (ro,path="cluster-tls-config.yaml")
      /etc/alertmanager/config from config-volume (rw)
      /etc/alertmanager/config_out from config-out (ro)
      /etc/alertmanager/web_config/web-config.yaml from web-config (ro,path="web-config.yaml")
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wdfqf (ro)
  config-reloader:
    Image:      quay.io/prometheus-operator/prometheus-config-reloader:v0.92.1
    Port:       8080/TCP
    Host Port:  0/TCP
    Command:
      /bin/prometheus-config-reloader
    Args:
      --listen-address=:8080
      --web-config-file=/etc/alertmanager/web_config/web-config.yaml
      --reload-url=http://127.0.0.1:9093/-/reload
      --config-file=/etc/alertmanager/config/alertmanager.yaml.gz
      --config-envsubst-file=/etc/alertmanager/config_out/alertmanager.env.yaml
      --watched-dir=/etc/alertmanager/config
    Environment:
      POD_NAME:  alertmanager-kube-prometheus-stack-alertmanager-0 (v1:metadata.name)
      SHARD:     -1
    Mounts:
      /etc/alertmanager/config from config-volume (ro)
      /etc/alertmanager/config_out from config-out (rw)
      /etc/alertmanager/web_config/web-config.yaml from web-config (ro,path="web-config.yaml")
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wdfqf (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  alertmanager-kube-prometheus-stack-alertmanager-db:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  alertmanager-kube-prometheus-stack-alertmanager-db-alertmanager-kube-prometheus-stack-alertmanager-0
    ReadOnly:   false
  config-volume:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  alertmanager-kube-prometheus-stack-alertmanager-generated
    Optional:    false
  tls-assets:
    Type:                Projected (a volume that contains injected data from multiple sources)
    SecretName:          alertmanager-kube-prometheus-stack-alertmanager-tls-assets-0
    SecretOptionalName:  <nil>
  config-out:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     Memory
    SizeLimit:  <unset>
  web-config:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  alertmanager-kube-prometheus-stack-alertmanager-web-config
    Optional:    false
  cluster-tls-config:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  alertmanager-kube-prometheus-stack-alertmanager-cluster-tls-config
    Optional:    false
  kube-api-access-wdfqf:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              role=addons
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age                    From               Message
  ----     ------            ----                   ----               -------
  Warning  FailedScheduling  2m44s (x2 over 7m48s)  default-scheduler  0/3 nodes are available: 1 node(s) didn't match Pod's node affinity/selector, 2 Too many pods. no new claims to deallocate, preemption: 0/3 nodes are available: 1 Preemption is not helpful for scheduling, 2 No preemption victims found for incoming pod.
  Warning  FailedScheduling  2m43s (x2 over 7m47s)  karpenter          Failed to schedule pod, incompatible requirements, label "role" does not have known values