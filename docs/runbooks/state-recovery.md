# State recovery runbook

1. Stop all Terraform operations and copy the current state to protected local storage.
2. Run `terraform state list` and compare it with labeled containers, networks, and volumes.
3. Restore the latest trusted state backup when available.
4. For an existing unmanaged resource, declare it first and use `terraform import` with its Docker ID.
5. Run `terraform plan` and require a no-op or fully understood reconciliation before applying.
6. Never commit recovered state or post it in logs/issues.
7. Record the cause, commands, resource IDs, and follow-up prevention.
