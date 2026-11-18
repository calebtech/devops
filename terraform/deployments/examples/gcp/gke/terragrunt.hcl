include "common" {
    path = find_in_parent_folders("common.hcl")
}

terraform {
    source = "../../../../modules/gcp/gke"
}

dependency "networking" {
    config_path = "../networking"

    mock_outputs = {
        network_name = "mock-vpc"
        subnet_name  = "mock-subnet"
    }
    mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
    network_name = dependency.networking.outputs.network_name
    subnet_name  = dependency.networking.outputs.subnet_name

    machine_type = "e2-standard-2"
    spot         = true
    min_nodes    = 1
    max_nodes    = 2
}
