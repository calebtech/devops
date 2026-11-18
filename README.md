# devops

Terraform modules and Terragrunt deployments for AWS, GCP and local Kubernetes.

```
terraform/
├── modules/
│   ├── aws/
│   │   ├── vpc/              # VPC, public/private subnets, IGW, NAT
│   │   └── helm-release/     # Helm release on an EKS cluster
│   ├── gcp/
│   │   ├── networking/       # VPC, subnet, Cloud NAT
│   │   ├── gke/              # zonal GKE cluster + one autoscaling node pool
│   │   └── managed-cert/     # Google-managed SSL certificate (optional)
│   └── helm-release/
│       └── helm-local/       # Helm release on a local cluster (kubeconfig)
└── deployments/examples/     # standalone example units, local state
    ├── aws/                  # vpc, helm-ecr
    ├── gcp/                  # common.hcl + networking, gke, managed-cert
    └── local/                # helm-local

environments/
├── local-dev/                # local cluster: argocd, argo-rollouts, kargo (helm-local)
└── gcp/                      # GCP: root.hcl (GCS state) + sandbox
```

## Usage

| Cloud | Where | Docs |
|---|---|---|
| GCP | `environments/gcp/<env>` | [environments/gcp/README.md](environments/gcp/README.md) |
| AWS | `terraform/deployments/examples/aws/<unit>` | module `vars.tf` files |
| GCP examples | `terraform/deployments/examples/gcp/<unit>` | [environments/gcp/README.md](environments/gcp/README.md) |
| Local | `environments/local-dev/helm/<chart>` | [environments/local-dev/helm/kargo/README.md](environments/local-dev/helm/kargo/README.md) |

```bash
# GCP: whole environment in dependency order
cd environments/gcp/sandbox && terragrunt run --all plan

# Local Helm charts
cd environments/local-dev/helm/argocd && terragrunt apply
```

To add AWS environments, mirror the GCP layout: `environments/aws/root.hcl` (S3 backend + provider)
and `environments/aws/<env>/<unit>/terragrunt.hcl` pointing at `terraform/modules/aws/<module>`.
