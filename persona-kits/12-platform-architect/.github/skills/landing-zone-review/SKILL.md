---
name: Landing Zone Review
description: "Use when reviewing or designing an Azure landing zone, enforcing platform guardrails, or auditing a new subscription. Triggers on "landing zone", "management group", "platform baseline", "guardrails", "CAF", "subscription vending"."
---

# Landing Zone Review

## When to invoke
- "Review our landing zone design against CAF."
- "A team just got a new subscription - run the baseline check."
- "We need guardrails that do not block developer velocity."

## CAF reference

Microsoft Cloud Adoption Framework: Azure landing zone = pre-provisioned environment with identity, networking, governance, security baselines.

Key components:
- **Management group hierarchy**: Root -> Platform / Landing Zones / Decommissioned / Sandbox.
- **Policy baseline**: deny, audit, deployIfNotExists initiatives.
- **Identity**: Entra ID, Privileged Identity Management (PIM), break-glass accounts.
- **Network topology**: hub-spoke or virtual WAN.
- **Monitoring**: Log Analytics workspace, Defender for Cloud, Azure Monitor.
- **Subscription vending**: automated provisioning with baseline applied.

## Review checklist

### Management groups
- [ ] Hierarchy matches CAF reference (or has justified deviation).
- [ ] No subscriptions hanging off tenant root.
- [ ] Sandbox isolated with budget caps and network disconnection.

### Policy
- [ ] Deny non-approved regions.
- [ ] Deny public IPs on managed resources (with defined exceptions).
- [ ] Require tags: `owner`, `costCenter`, `environment`, `dataClassification`.
- [ ] Deny SKUs above approved list (cost control).
- [ ] Audit diagnostic settings enabled on all resources.

### Identity
- [ ] Break-glass accounts exist and are monitored.
- [ ] PIM enforced for all privileged roles.
- [ ] Conditional Access blocks legacy auth.
- [ ] Custom roles justified (prefer built-in).

### Networking
- [ ] Hub-spoke or vWAN with centralised egress.
- [ ] Azure Firewall / NVA for outbound traffic inspection.
- [ ] Private endpoints for PaaS where classification requires.
- [ ] DDoS Protection Standard on public-facing VNets.

### Monitoring
- [ ] Central Log Analytics workspace; 90+ day retention.
- [ ] Defender for Cloud at Standard tier.
- [ ] Azure Monitor alerts for platform-level events (role assignments, policy violations).

### Landing zone as code
- [ ] Bicep or Terraform, in a git repo, with required reviews.
- [ ] No click-ops in production subscriptions.

## Output template
```markdown
## Landing Zone Review - <Tenant/Scope> - <Date>

### Compliance score
- Management groups: PASS
- Policy baseline: 18/22 controls PASS
- Identity: PASS
- Networking: 7/8 controls PASS (1 exception)
- Monitoring: PASS

### Findings
| ID | Severity | Area | Finding | Remediation | Owner |
|----|----------|------|---------|-------------|-------|
| F01 | High | Policy | Public IPs allowed on VMs | Add deny policy | Jordan |
```

## Quality gate
Any High finding blocks production workload onboarding until remediated.
