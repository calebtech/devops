variable "cluster_name" {
  type    = string
  default = null
}

variable "ecr_region" {
  type    = string
  default = null
}

variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
}

variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "chart_name" {
  type = string
}

variable "chart_repo" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "values" {
  type    = list(string)
  default = []
}

variable "timeout" {
  type    = number
  default = 600
}