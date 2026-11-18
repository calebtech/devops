terraform {
  required_providers {
    aws = {
      source = "aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = var.assume_role_arn
  }
}