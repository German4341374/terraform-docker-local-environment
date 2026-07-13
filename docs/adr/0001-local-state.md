# ADR 0001: Use local state for a local learning environment

- Status: Accepted
- Date: 2026-07-13

Local state avoids cloud accounts and keeps the demonstration self-contained. It is gitignored and
never uploaded. This is unsuitable for teams because it lacks shared locking, centralized access
control, and managed encryption.
