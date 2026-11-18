include "root" {
    path = "${get_terragrunt_dir()}/../../env.hcl"
    expose = true
}

locals {
  shared = include.root.locals
}

terraform {
  source = "../../../../terraform/modules/helm-release/helm-local"
}

inputs = {

  name            = local.shared.argocd_name
  chart_name      = local.shared.argocd_chart_name
  namespace       = local.shared.argocd_namespace
  chart_repo      = local.shared.argocd_chart_repo
  chart_version   = local.shared.argocd_chart_version

  values = [templatefile("values.yaml", {})]
}