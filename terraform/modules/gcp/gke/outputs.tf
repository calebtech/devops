output "cluster_name" {
  value = google_container_cluster.this.name
}

output "connect_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.this.name} --zone ${var.zone} --project ${var.project_id}"
}
