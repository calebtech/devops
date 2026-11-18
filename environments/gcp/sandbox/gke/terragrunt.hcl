include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}/terraform/modules/gcp/gke"
}

dependency "networking" {
  config_path = "../networking"

  mock_outputs = {
    network_name = "mock-vpc"
    subnet_name  = "mock-subnet"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = merge(include.root.locals.env.gke, {
  network_name = dependency.networking.outputs.network_name
  subnet_name  = dependency.networking.outputs.subnet_name
})
