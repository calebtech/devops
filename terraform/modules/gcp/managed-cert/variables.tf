variable "environment" {
  type        = string
  description = "Environment name - used as the prefix for the certificate name"
}

variable "domains" {
  type        = list(string)
  description = "Domains on the Google-managed certificate (ingress hosts)"
}
