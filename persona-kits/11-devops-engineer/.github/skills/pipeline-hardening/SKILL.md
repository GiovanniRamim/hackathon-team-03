---
name: Pipeline Hardening
description: "Use when hardening a CI/CD pipeline, moving to OIDC, signing artifacts, or meeting SLSA requirements. Triggers on 'SLSA', 'supply chain', 'OIDC', 'sigstore', 'cosign', 'pipeline security', 'GHA hardening'."
---

# Pipeline Hardening

## When to invoke
- "Harden our GitHub Actions / Azure DevOps / GitLab pipeline."
- "Move from long-lived secrets to OIDC."
- "Reach SLSA Level 2/3."
- "Sign our container images."

## Threat model (short list)
1. **Stolen secrets** from pipeline logs or compromised runner.
2. **Malicious dependency** published upstream or typosquatted.
3. **Compromised third-party action / shared step**.
4. **Tampered artifact** between build and deploy.
5. **Privilege escalation** via over-broad pipeline permissions.

## Controls (ranked by ROI)
### Tier 1 - do these first
- [ ] **OIDC to the cloud** - no long-lived cloud credentials stored as secrets. Federated identity with short-lived tokens.
- [ ] **Pin third-party actions by SHA**, not tag (`actions/checkout@<sha>` with a comment showing the version).
- [ ] **`permissions:` block** on every workflow, default `contents: read`, grant upward only where needed.
- [ ] **Branch protection**: required reviews, required status checks, no force-push, signed commits on main.
- [ ] **Secret scanning + push protection** enabled org-wide.
- [ ] **Dependabot / Renovate** for dependencies and actions.

### Tier 2 - supply chain integrity
- [ ] **SBOM** generated on every build (Syft / CycloneDX).
- [ ] **Artifact signing** with Cosign (keyless via OIDC preferred).
- [ ] **Provenance** (SLSA v1.0 attestation) published with the artifact.
- [ ] **Verify signatures on deploy** - the deploy job refuses unsigned artifacts.
- [ ] **Vulnerability scan** (Trivy / Grype) on image; fail on Critical/High with justified exceptions.

### Tier 3 - mature
- [ ] **Hermetic / reproducible builds** where feasible.
- [ ] **Two-party review** for release pipelines.
- [ ] **Runner hardening**: ephemeral, network-egress restricted, no shared mutable state.

## Anti-patterns
- Storing `AWS_ACCESS_KEY_ID` / `AZURE_CLIENT_SECRET` as a repo secret when OIDC is available.
- `permissions: write-all`.
- `@main` or `@v3` floating tags on third-party actions.
- Deploying an artifact built in a different pipeline without verifying its signature.
- Secrets echoed in logs via unquoted shell expansion.

## References
- [SLSA v1.0](https://slsa.dev/spec/v1.0/)
- [GitHub - Security hardening for GHA](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [Sigstore / Cosign](https://docs.sigstore.dev/)
- [OpenSSF Scorecard](https://scorecard.dev/)
