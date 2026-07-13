# ADR 0002: CI plans but never applies

- Status: Accepted
- Date: 2026-07-13

Pull request code is untrusted and must not mutate runner or external infrastructure. CI uses mocked
tests plus a non-applying, non-refreshing plan. Apply remains an explicit local operator decision
after review of a saved plan.
