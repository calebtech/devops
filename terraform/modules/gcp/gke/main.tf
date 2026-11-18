# Zonal GKE cluster with private nodes and a single autoscaling node pool.

resource "google_container_cluster" "this" {
  name     = "${var.environment}-gke"
  location = var.zone

  network    = var.network_name
  subnetwork = var.subnet_name

  # Node pool is managed separately below
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = var.deletion_protection

  release_channel {
    channel = var.release_channel
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr
  }

  # Only restrict the control plane when CIDRs are given (empty = reachable from anywhere, still needs IAM)
  dynamic "master_authorized_networks_config" {
    for_each = length(var.authorized_cidrs) > 0 ? [1] : []
    content {
      dynamic "cidr_blocks" {
        for_each = var.authorized_cidrs
        content {
          cidr_block = cidr_blocks.value
        }
      }
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "this" {
  name     = "${var.environment}-pool"
  location = var.zone
  cluster  = google_container_cluster.this.name

  autoscaling {
    min_node_count = var.min_nodes
    max_node_count = var.max_nodes
  }

  node_config {
    machine_type = var.machine_type
    spot         = var.spot
    disk_size_gb = var.disk_size_gb
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}
