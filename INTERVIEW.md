# Interview questions and answers

## 1. Why use Terraform for local Docker?
It demonstrates declarative lifecycle, planning, state, dependencies, and review without cloud cost.

## 2. What does state do?
It maps Terraform addresses to Docker IDs and stores attributes required to calculate changes.

## 3. Why must state not be committed?
It can contain passwords, IDs, topology, and other sensitive operational data.

## 4. Does `sensitive = true` encrypt state?
No. It only redacts normal CLI output; state still contains the value.

## 5. Why use `for_each` for applications?
Stable keys produce understandable addresses and controlled replica changes.

## 6. Why use locals?
Locals centralize naming, labels, volume maps, and replica-derived structures.

## 7. What does input validation add?
Invalid ports, names, environments, weak passwords, sockets, and latest tags fail before mutation.

## 8. Why pin the provider?
Provider schema and behavior affect plans; pinning makes upgrades explicit and reviewable.

## 9. Why keep a dependency lock file?
It records selected provider versions and checksums for reproducible initialization.

## 10. Why is PostgreSQL not published?
Only internal services need it, so a host port would add unnecessary attack surface.

## 11. Why bind Nginx to loopback?
The demonstration is local and should not become reachable from the LAN by accident.

## 12. What do health checks prove?
They show process-level readiness, but not complete business behavior or observability.

## 13. Why does CI never apply?
Pull request code is untrusted and must not mutate infrastructure or persistent runner state.

## 14. Why upload plan text instead of the binary plan?
Text is review evidence; binary plans may contain sensitive values and can be applied.

## 15. How do mocked Terraform tests help?
They verify expressions, validations, replica behavior, and outputs without a Docker daemon.

## 16. What does TFLint catch?
Terraform-specific errors, deprecated patterns, naming problems, and suspicious declarations.

## 17. What does Checkov add?
It applies security policies to infrastructure configuration before resources exist.

## 18. Manual Docker or Terraform?
Manual commands are fast for experiments; Terraform adds reproducibility, plan review, and drift management.

## 19. Terraform or Docker Compose?
Compose is more idiomatic for local applications; Terraform better demonstrates shared IaC concepts and state.

## 20. What happens when replica count decreases?
Terraform plans destruction for removed keyed instances; review the plan before applying.

## 21. What happens to volumes on destroy?
Managed volumes are destroyed and data is lost unless backed up separately.

## 22. How do you recover lost state?
Restore a protected backup or import declared resources by Docker ID, then confirm the plan.

## 23. Why use saved plans?
Apply executes the exact reviewed proposal rather than recalculating after the review.

## 24. What is drift?
Drift is a difference between declared configuration, state, and real Docker resources.

## 25. What would you improve for production?
Use an orchestrator, managed secrets, digest pins, protected remote state, monitoring, and backup testing.
