variable "environment" {
  type        = string
  description = "Prefix for every resource name"
}

variable "region" {
  type        = string
  default     = "europe-west1"
  description = "Region for the subnet and NAT"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.10.0.0/20"
  description = "Primary range for nodes"
}

variable "pods_cidr" {
  type        = string
  default     = "10.20.0.0/16"
  description = "Secondary range for GKE pods"
}

variable "services_cidr" {
  type        = string
  default     = "10.30.0.0/20"
  description = "Secondary range for GKE services"
}
