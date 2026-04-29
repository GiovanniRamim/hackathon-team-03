---
name: IaC Review
description: "Use when reviewing Terraform, Bicep, or CloudFormation, checking for drift, or hardening infrastructure code. Triggers on 'review terraform', 'review bicep', 'IaC review', 'drift detection', 'state file'."
---

# IaC Review

## When to invoke
- "Review this Terraform module."
- "Why is our plan showing drift?"
- "Is this Bicep production-ready?"

## Review checklist
### Structure
- [ ] Modules are **composable** and have a single responsibility (one module = one logical stack, not one resource).
- [ ] **No hardcoded values** - everything parameterized with sensible defaults.
- [ ] **Inputs documented** (description, type, validation rules); outputs too.
- [ ] **README** at the module root with usage example.

### State & backends
- [ ] **Remote state** with locking (S3+DynamoDB, Azure Storage with blob lease, GCS).
- [ ] State is **never committed** to git; `.gitignore` covers `*.tfstate*`.
- [ ] Separate state per environment; no cross-env implicit coupling.
- [ ] State access is gated by IAM, not shared credentials.

### Security
- [ ] No secrets in code or variable defaults - use Key Vault / Secrets Manager / SOPS.
- [ ] Least-privilege IAM; no `*:*` or `Resource: "*"` unless justified.
- [ ] Encryption at rest and in transit enabled on all data stores.
- [ ] Public access explicitly denied unless intentional; log it in the module README if so.
- [ ] `tfsec` / `checkov` / `PSRule` clean, or exceptions documented.

### Change safety
- [ ] `terraform plan` is included in PRs as a comment (Atlantis / tfcmt / GH Actions).
- [ ] `prevent_destroy` on stateful resources (databases, KV, storage accounts).
- [ ] Provider versions **pinned** (`~>` with explicit major and minor).
- [ ] Module versions pinned.
- [ ] Destructive diffs require a second approver.

### Drift
- [ ] Scheduled drift detection (daily `terraform plan -detailed-exitcode`, or Driftctl).
- [ ] Drift creates a ticket automatically; is never left silent.
- [ ] No manual changes in the console without a follow-up codification.

## Common findings
- **`count` used for lists that reorder** → use `for_each` with stable keys.
- **`depends_on` everywhere** → usually a signal of missing implicit deps; remove unless truly needed.
- **Data sources used for values available at plan time** → unnecessary API calls, flakes CI.
- **Environment differences by string interpolation of `terraform.workspace`** → fragile; use tfvars or separate stacks.

## References
- [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/style)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [tfsec](https://aquasecurity.github.io/tfsec/), [checkov](https://www.checkov.io/)
