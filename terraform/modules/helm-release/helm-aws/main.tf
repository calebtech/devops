data "aws_eks_cluster" "this" {
  name  = var.cluster_name
}

provider "helm" {
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

resource "helm_release" "eks" {
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

