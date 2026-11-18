# Optional - delete this folder if you don't need an HTTPS certificate.
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/modules/gcp/managed-cert"
}

inputs = {
  domains = ["app.example.com"] # <-- your domain(s), DNS must point at the ingress IP
}
