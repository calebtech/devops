terraform {
  required_providers {
    aws = {
        source = "aws"
        version = "~> 6.31"
    }
    helm = {
        source = "helm"
        version = "~> 2.10"
    }
  }
}
terraform {
  backend "local" {}
}