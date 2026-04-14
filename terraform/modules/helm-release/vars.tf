variable "cluster_name" {
    description = "Cluster Name"
    type = string
}

variable "ecr_region" {
  description = "ECR Region for Repos"
  type = string
}

variable "name" {
  description = "Release chart name"
  type = string
}

variable "chart_name" {
  description = "Helm chart name"
  type = string
}

variable "namespace" {
  description = "Chart Namespace"
  type = string
}

variable "chart_repo" {
  description = "Chart repo/location"
  type = string
}

variable "chart_version" {
  description = "Chart version"
  type = string
}

variable "values" {
  description = "YAML values for the chart"
  type = list(string)
  default = []
}

variable "timeout" {
    description = "Time out for kubernetes operation to seed"
    type = number
    default = 300
}
variable "kubeconfig_path" {
  description = "Kubeconfig for local deployment"
  type = string
  default = "~/.kube/config"

}