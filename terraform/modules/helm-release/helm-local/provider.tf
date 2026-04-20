terraform {
  required_providers {
    helm = {
        source = "helm"
        version = "~> 2.10"
    }
  }
}
terraform {
  backend "local" {}
}