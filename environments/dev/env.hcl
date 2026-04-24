locals {
  environment = "dev"
  # For local deployments
  ## ArgoCD Configs
  argocd_name            = "argocd"
  argocd_namespace       = "argocd"
  argocd_chart_repo      = "https://argoproj.github.io/argo-helm"
  argocd_chart_name      = "argo-cd"
  argocd_chart_version   = "5.51.6"

  ## Kargo Configs
  kargo_name            = "kargo"
  kargo_namespace       = "kargo"
  kargo_chart_repo      = "oci://ghcr.io/akuity/kargo-charts"
  kargo_chart_name      = "kargo"
  kargo_chart_version   = "1.3.1"
}




