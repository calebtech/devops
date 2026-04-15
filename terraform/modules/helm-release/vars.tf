variable "cluster_name" {
  type        = string
  default     = null
  description = "EKS cluster name. Required when ecr_region is set so the Helm provider can authenticate via aws eks get-token."
}

variable "ecr_region" {
  type        = string
  default     = null
  description = "AWS region hint for EKS mode. When null, the module uses the local Helm provider (e.g. Minikube) with kubeconfig_path instead of EKS."
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig file used by the local Helm provider when ecr_region is null."
  default     = "~/.kube/config"
}

variable "name" {
  type        = string
  description = "Helm release name (Kubernetes resource name for the release)."
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace for the release. The module sets create_namespace = true."
}

variable "chart_name" {
  type        = string
  description = "Helm chart name in the remote repository (e.g. argo-cd)."
}

variable "chart_repo" {
  type        = string
  description = "Helm chart repository URL (OCI or HTTP index)."
}

variable "chart_version" {
  type        = string
  description = "Chart version string to install (SemVer or repo-specific tag)."
}

variable "values" {
  type        = list(string)
  description = "List of YAML strings merged as Helm values (each string is a values file body)."
  default     = []
}

variable "timeout" {
  type        = number
  description = "Seconds to wait for Helm install/upgrade before failing."
  default     = 600
}
