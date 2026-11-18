# Included by every unit in environments/gcp/<env>/<unit>/.
# Generates the GCS state backend and google provider from <env>/env.hcl.

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
}

# State: gs://<project_id>-tfstate/<env>/<unit>/ - Terragrunt creates the bucket on first run.
remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    project  = local.env.project_id
    location = local.env.region
    bucket   = "${local.env.project_id}-tfstate"
    prefix   = path_relative_to_include()
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "google" {
      project = "${local.env.project_id}"
      region  = "${local.env.region}"
    }
  EOF
}

# Passed to every module - each one ignores what it doesn't declare.
inputs = {
  environment = local.env.environment
  project_id  = local.env.project_id
  region      = local.env.region
  zone        = local.env.zone
}
