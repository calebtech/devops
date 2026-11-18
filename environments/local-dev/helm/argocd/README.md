# Argo CD

## Accessing Argo CD

### Port-forward

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Open https://localhost:8080. The certificate is self-signed, so accept the browser warning.

### Admin password

Username: `admin`

```sh
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d; echo
```

> `argocd-initial-admin-secret` is only valid until the password is changed
> (`argocd account update-password`). After that, the secret can be deleted and this command will no longer work.

### CLI login

```sh
argocd login localhost:8080 --username admin --insecure
```
