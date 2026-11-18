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

  name            = local.shared.argo_rollouts_name
  chart_name      = local.shared.argo_rollouts_chart_name
  namespace       = local.shared.argo_rollouts_namespace
  chart_repo      = local.shared.argo_rollouts_chart_repo
  chart_version   = local.shared.argo_rollouts_chart_version

  values = [templatefile("values.yaml", {})]
}