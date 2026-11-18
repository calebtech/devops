variable "environment" {
  type        = string
  description = "Prefix for every resource name"
}

variable "project_id" {
  type        = string
  description = "GCP project id"
}

variable "zone" {
  type        = string
  default     = "europe-west1-b"
  description = "Zone for the (zonal) cluster"
}

variable "network_name" {
  type        = string
  description = "VPC name (from the networking module)"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name with 'pods' and 'services' secondary ranges (from the networking module)"
}

variable "machine_type" {
  type        = string
  default     = "e2-standard-2"
  description = "Node machine type"
}

variable "spot" {
  type        = bool
  default     = true
  description = "Use Spot VMs for nodes (much cheaper, can be preempted)"
}

variable "min_nodes" {
  type        = number
  default     = 1
  description = "Minimum nodes in the pool"
}

variable "max_nodes" {
  type        = number
  default     = 3
  description = "Maximum nodes in the pool"
}

variable "disk_size_gb" {
  type        = number
  default     = 50
  description = "Node boot disk size (GB)"
}

variable "release_channel" {
  type        = string
  default     = "REGULAR"
  description = "GKE release channel: RAPID, REGULAR or STABLE"
}

variable "master_ipv4_cidr" {
  type        = string
  default     = "172.16.0.0/28"
  description = "/28 range for the control plane"
}

variable "authorized_cidrs" {
  type        = list(string)
  default     = []
  description = "CIDRs allowed to reach the control plane. Empty = no restriction"
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "Block terraform destroy of the cluster"
}
