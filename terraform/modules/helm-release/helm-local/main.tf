# Local Provider (e.g. Minikube)
provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "local" {
  name       = var.name
  chart      = var.chart_name
  namespace  = var.namespace
  repository = var.chart_repo
  version    = var.chart_version

  create_namespace = true
  values           = var.values

  timeout           = var.timeout
  dependency_update = true
  atomic            = true
}