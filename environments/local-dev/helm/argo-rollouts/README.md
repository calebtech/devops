# Argo Rollouts

## Accessing the Argo Rollouts Dashboard

The Helm chart does not deploy the dashboard by default (`dashboard.enabled: false`), and Argo Rollouts has no login.

### Option 1: kubectl plugin (no chart changes)

```sh
kubectl argo rollouts dashboard
```

Open http://localhost:3100.

### Option 2: deploy the dashboard via Helm and port-forward

Add to `values.yaml`:

```yaml
dashboard:
  enabled: true
```

Then:

```sh
kubectl port-forward svc/argo-rollouts-dashboard -n argo-rollouts 3100:3100
```

Open http://localhost:3100.
