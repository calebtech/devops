# Kargo API Setup

## Installation Steps

### 1. Generate a Password and a Signing Key

There are no default values for these two fields, so you must provide your own.

Run the following commands to generate a secure password, hash it, and create a signing key:

```sh
pass=$(openssl rand -base64 48 | tr -d "=+/" | head -c 32)
echo "Password: $pass"
hashed_pass=$(htpasswd -bnBC 10 "" $pass | tr -d ':
')
signing_key=$(openssl rand -base64 48 | tr -d "=+/" | head -c 32)
echo "Signing Key: $signing_key"
```

### 2. Create the Kubernetes Secret

Once you have generated the password hash and signing key, use the following `kubectl` command to create the necessary Kubernetes Secret:

```sh
kubectl --namespace kargo create secret generic kargo-api-secret \
  --from-literal=ADMIN_ACCOUNT_PASSWORD_HASH="$hashed_pass" \
  --from-literal=ADMIN_ACCOUNT_TOKEN_SIGNING_KEY="$signing_key" \
  --dry-run=client -o yaml | kubectl apply -f -
```

## Accessing Kargo

### Port-forward

The Kargo UI and API are both served by the `kargo-api` service:

```sh
kubectl port-forward svc/kargo-api -n kargo 8443:443
```

Open https://localhost:8443. The certificate is self-signed, so accept the browser warning.

### Admin password

Only the bcrypt hash is stored (in `kargo-api-secret`), so the plaintext password **cannot be read back from the cluster**.
It is the `Password:` value printed in step 1. If you've lost it, re-run steps 1 and 2, then restart the API:

```sh
kubectl rollout restart deployment/kargo-api -n kargo
```

### CLI login

```sh
kargo login https://localhost:8443 --admin --insecure-skip-tls-verify
```
