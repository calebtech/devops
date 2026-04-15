include "root" {
    path = "${get_terragrunt_dir()}/../../env.hcl"
    expose = true
}

locals {
    shared = include.root.locals  
}

terraform {
  source = "../../../../terraform/modules/helm-release"
}

inputs = {
  ecr_region = null   # THIS enables local mode

  name       = local.shared.name
  chart      = local.shared.chart_name
  namespace  = local.shared.namespace
  repository = local.shared.chart_repo
  version    = local.shared.chart_version

  values = [
    <<EOF
server:
  service:
    type: ClusterIP   # 🔥 IMPORTANT for Minikube

  extraArgs:
    - --insecure

configs:
  params:
    server.insecure: true
EOF
  ]
}