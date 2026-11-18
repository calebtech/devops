# GCP

A minimal GKE setup: **networking** (VPC, subnet, NAT) → **gke** (one cluster, one autoscaling node pool),
plus an optional **managed-cert**. Modules live in `terraform/modules/gcp/`.

## Deploy

**1. Log in and enable the APIs** (once per machine / project):

```bash
gcloud auth login
gcloud auth application-default login
gcloud services enable compute.googleapis.com container.googleapis.com --project <project_id>
```

**2. Set your project** in `sandbox/env.hcl`:

```hcl
project_id = "my-gcp-project-id"
```

**3. Deploy:**

```bash
cd environments/gcp/sandbox
terragrunt run --all apply
```

Takes ~10 minutes. The state bucket `gs://<project_id>-tfstate` is created on the first run.

**4. Connect:**

```bash
gcloud container clusters get-credentials sandbox-gke --zone europe-west1-b --project <project_id>
kubectl get nodes
```

## Change settings

Edit the `gke` block in `sandbox/env.hcl` (machine type, spot, node counts, `authorized_cidrs`) and run
`terragrunt run --all apply` again. All options and defaults are in `terraform/modules/gcp/*/variables.tf`.

No HTTPS certificate needed? Delete `sandbox/managed-cert/`.

## New environment

```bash
cp -r environments/gcp/sandbox environments/gcp/prod
# edit prod/env.hcl: environment = "prod", project_id = ...
cd environments/gcp/prod && terragrunt run --all apply
```

## Destroy

```bash
cd environments/gcp/sandbox
terragrunt run --all destroy
```

## Troubleshooting

- `could not find default credentials`: run `gcloud auth application-default login`.
- `API has not been used in project`: run the `gcloud services enable` command from step 1.
- `403` on the state bucket or resources: your account needs `Editor` (or `Compute Admin` +
  `Kubernetes Engine Admin` + `Storage Admin`) on the project.
