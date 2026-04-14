locals {
  use_eks = var.ecr_region != null
}

# Only fetch eks data if needed
data "aws_eks_cluster" "this" {
  count = local.use_eks ? 1 : 0
  name = var.cluster_name
}


provider "helm" {
  alias = "eks"
  kubernetes {
    host = local.use_eks ? data.aws_eks_cluster.this[0].endpoint : null

    cluster_ca_certificate = local.use_eks ? base64decode(data.aws_eks_cluster.this[0].certificate_authority[0].data) : null

    exec {
      api_version = "client.authentication.k8s.io/v1"
      command = "aws"
      args = ["eks", "get-token", "--cluster-name", var.cluster_name]
    }
  }

}

provider "helm" {
  alias = "local"

  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "this" {
  provider = local.use_eks ? helm.eks : helm.local

  name = var.name
  chart = var.chart_name
  namespace = var.namespace
  repository = var.chart_repo
  version = var.chart_version

  create_namespace = true
  values = var.values
  
  timeout = var.timeout
}