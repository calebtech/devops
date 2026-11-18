# Shared config for the GCP examples - included by every unit in this folder.
# The GCP modules have no provider block, so one is generated here.
# State stays local (terraform.tfstate in the unit's .terragrunt-cache).
# Auth: gcloud auth application-default login (see environments/gcp/README.md).

locals {
  environment = "example"
  project_id  = "my-gcp-project-id"
  region      = "europe-west1"
  zone        = "europe-west1-b"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-PROVIDER
    provider "google" {
      project = "${local.project_id}"
      region  = "${local.region}"
    }
  PROVIDER
}

# Common inputs - modules ignore the ones they don't declare
inputs = {
  environment = local.environment
  project_id  = local.project_id
  region      = local.region
  zone        = local.zone
}
