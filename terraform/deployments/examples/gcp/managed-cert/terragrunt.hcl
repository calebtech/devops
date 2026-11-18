include "common" {
    path = find_in_parent_folders("common.hcl")
}

terraform {
    source = "../../../../modules/gcp/managed-cert"
}

inputs = {
    domains = ["app.example.com"]
}
