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

  name            = local.shared.kargo_name
  chart_name      = local.shared.kargo_chart_name
  namespace       = local.shared.kargo_namespace
  chart_repo      = local.shared.kargo_chart_repo
  chart_version   = local.shared.kargo_chart_version

  values = [templatefile("values.yaml", {})]
}
