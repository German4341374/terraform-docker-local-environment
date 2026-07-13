# Five-minute employer demonstration

## Prepare

Start Docker, export a generated `TF_VAR_postgres_password`, run checks, and apply development.
Never claim a command passed unless you ran it. Keep GitHub Actions and the plan text open.

## 0:00–1:00 — architecture

Show the Mermaid diagram and explain the loopback-only proxy, internal network, replicas, PostgreSQL,
and two named volumes. Point out the focused `.tf` files.

## 1:00–2:00 — plan and abstractions

Run `terraform plan -var-file=environments/development.tfvars`. Show input validation, locals,
`for_each` for application replicas/volumes, provider pins, and sensitive output.

## 2:00–3:00 — live resources

Run `terraform output`, `docker ps --filter label=managed-by=terraform`, and
`curl http://127.0.0.1:8080/health`. Refresh `/` to show Nginx balancing between app names.

## 3:00–4:00 — state and CI safety

Explain that state contains resource IDs and secrets and is gitignored. Show CI read-only permissions,
mocked tests, TFLint, Checkov, plan artifact, and the deliberate absence of apply.

## 4:00–5:00 — lifecycle trade-offs

Show the manual Docker comparison and guarded destroy script. Explain saved-plan review, explicit
confirmation, volume destruction risk, and when Compose or Kubernetes would be a better choice.
