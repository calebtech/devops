locals {
    # For local deployments
  environment = "dev"

  ## ArgoCD Configs
  argocd_name            = "argocd"
  argocd_namespace       = "argocd"
  argocd_chart_repo      = "https://argoproj.github.io/argo-helm"
  argocd_chart_name      = "argo-cd"
  argocd_chart_version   = "10.1.3"

  ##Argo Rollouts Configs
  argo_rollouts_name            = "argo-rollouts"
  argo_rollouts_namespace       = "argo-rollouts"
  argo_rollouts_chart_repo      = "https://argoproj.github.io/argo-helm"
  argo_rollouts_chart_name      = "argo-rollouts"
  argo_rollouts_chart_version   = "2.41.0"

  ## Kargo Configs
  kargo_name            = "kargo"
  kargo_namespace       = "kargo"
  kargo_chart_repo      = "oci://registry-1.docker.io/calebtech"
  kargo_chart_name      = "kargo"
  kargo_chart_version   = "1.10.8"
}




