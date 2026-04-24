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
