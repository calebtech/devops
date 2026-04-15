locals {
  use_eks = var.ecr_region != null
}

# -------------------------
# EKS Data (only when needed)
# -------------------------
data "aws_eks_cluster" "this" {
  count = local.use_eks ? 1 : 0
  name  = var.cluster_name
}

# -------------------------
# Providers
# -------------------------

# EKS Provider
provider "helm" {
  alias = "eks"

  kubernetes {
    host = data.aws_eks_cluster.this[0].endpoint

    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.this[0].certificate_authority[0].data
    )

    exec {
      api_version = "client.authentication.k8s.io/v1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    }
  }
}

# Local Provider (e.g. Minikube)
provider "helm" {
  alias = "local"

  kubernetes {
    config_path = var.kubeconfig_path
  }
}

# -------------------------
# Helm Release (EKS)
# -------------------------
resource "helm_release" "eks" {
  count = local.use_eks ? 1 : 0

  provider = helm.eks

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

# -------------------------
# Helm Release (Local)
# -------------------------
resource "helm_release" "local" {
  count = local.use_eks ? 0 : 1

  provider = helm.local

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