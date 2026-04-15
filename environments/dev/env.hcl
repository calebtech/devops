locals {
  environment = "dev"
# For local deployments
  name       = "argocd"
  namespace  = "argocd"
  chart_repo = "https://argoproj.github.io/argo-helm"
  chart_name      = "argo-cd"
  chart_version    = "5.51.6"
}




