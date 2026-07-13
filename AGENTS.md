# Agent Guidelines

- Use English and never commit state, plans, passwords, tokens, or personal data.
- Preserve provider pins and the dependency lock file.
- Keep PostgreSQL unexposed and proxy binding limited to loopback.
- Use variables with validation and mark secret-derived outputs sensitive.
- Never add automatic apply to pull request workflows.
- Run fmt, validate, Terraform tests, TFLint, and Checkov after changes.
- Update state and destroy runbooks when resource lifecycle changes.
