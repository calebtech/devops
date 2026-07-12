locals {
  environment = "dev"
  # For local deployments
  ## ArgoCD Configs
  argocd_name            = "argocd"
  argocd_namespace       = "argocd"
  argocd_chart_repo      = "https://argoproj.github.io/argo-helm"
  argocd_chart_name      = "argo-cd"
  argocd_chart_version   = "10.1.3"

  ## Kargo Configs
  kargo_name            = "kargo"
  kargo_namespace       = "kargo"
  kargo_chart_repo      = "oci://registry-1.docker.io/calebtech"
  kargo_chart_name      = "kargo"
  kargo_chart_version   = "1.10.8"
}




