# The only file you need to edit for an environment.
locals {
  environment = "sandbox"            # prefix of every resource name
  project_id  = "my-gcp-project-id"  # <-- set your project
  region      = "europe-west1"
  zone        = "europe-west1-b"

  gke = {
    machine_type = "e2-standard-2"
    spot         = true
    min_nodes    = 1
    max_nodes    = 3
    # authorized_cidrs = ["203.0.113.10/32"] # lock the control plane to your IP
  }
}
