$ kget applicationset -n argocd
NAME       AGE
org-apps   19h
(.venv) 
Gaël@Ga□lo-PC MINGW64 /c/IaC-and-DevOps/Projs/els-k8s-infra (chore)
$ kdesc applicationset org-apps -n argocd
Name:         org-apps
Namespace:    argocd
Labels:       <none>
Annotations:  <none>
API Version:  argoproj.io/v1alpha1
Kind:         ApplicationSet
Metadata:
  Creation Timestamp:  2026-08-03T06:43:05Z
  Generation:          1
  Resource Version:    3185537
  UID:                 66c59c03-58ee-4e8a-828a-691e82764730
Spec:
  Generators:
    Scm Provider:
      Filters:
        Paths Exist:
          k8s-deployment
        Repository Match:  .*
      Github:
        App Secret Name:  argocd-repo-creds-elsgit1
        Organization:     Elsgit1
  Go Template:            true
  Template:
    Metadata:
      Finalizers:
        resources-finalizer.argocd.argoproj.io
      Name:  {{ .repository | lower }}
    Spec:
      Destination:
        Server:  https://kubernetes.default.svc
      Project:   default
      Source:
        Path:             k8s-deployment
        Repo URL:         {{ .url }}
        Target Revision:  {{ .branch }}
      Sync Policy:
        Automated:
          Prune:      true
          Self Heal:  true
Status:
  Conditions:
    Last Transition Time:  2026-08-03T06:43:05Z
    Message:               error listing repos: error listing repositories for Elsgit1: GET https://api.github.com/orgs/Elsgit1/repos?per_page=100: 404 Not Found []
    Reason:                ApplicationGenerationFromParamsError
    Status:                True
    Type:                  ErrorOccurred
    Last Transition Time:  2026-08-03T06:43:05Z
    Message:               error listing repos: error listing repositories for Elsgit1: GET https://api.github.com/orgs/Elsgit1/repos?per_page=100: 404 Not Found []
    Reason:                ErrorOccurred
    Status:                False
    Type:                  ParametersGenerated
    Last Transition Time:  2026-08-03T06:43:05Z
    Message:               error listing repos: error listing repositories for Elsgit1: GET https://api.github.com/orgs/Elsgit1/repos?per_page=100: 404 Not Found []
    Reason:                ErrorOccurred
    Status:                False
    Type:                  ResourcesUpToDate
  Health:
    Message:  error listing repos: error listing repositories for Elsgit1: GET https://api.github.com/orgs/Elsgit1/repos?per_page=100: 404 Not Found []
    Status:   Degraded
Events:       <none>
(.venv) 