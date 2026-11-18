output "certificate_name" {
  value       = google_compute_managed_ssl_certificate.default.name
  description = "Reference it from the ingress annotation networking.gke.io/pre-shared-cert"
}
