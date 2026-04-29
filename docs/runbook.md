---
title: "Runbook — SIFAP 2.0 Team Repository"
description: "How to run the system locally, in CI, and in Azure"
author: "DevOps Engineer (your team)"
date: "2026-04-29"
version: "1.0.0"
status: "draft"
tags: ["runbook", "operations", "devops", "deploy"]
---

# Runbook

> What to do when something runs (or doesn't). The DevOps Engineer owns this file.

## Local — first time

```bash
./scripts/setup.sh         # checks tools, clones reference, sets up symlinks
docker compose up -d       # spins up Postgres + backend + frontend
```

Then:
- Backend health: <http://localhost:8080/actuator/health>
- Swagger UI: <http://localhost:8080/swagger-ui.html>
- Frontend: <http://localhost:3001>

Default credentials are documented in `prototype/README.md`.

## Local — daily

```bash
docker compose up -d        # if it's down
./scripts/check.sh          # before pushing
git status                  # never commit symlinks (legacy/, prototype/, infra/)
```

## CI

Triggered automatically on push to `main`, `develop`, `spec/**`, `impl/**`.

| Workflow | What it does | When |
|----------|--------------|------|
| `ci.yml` | Backend `mvn verify`, frontend lint+test+typecheck, Terraform fmt+validate | Every push and PR |
| `spec-quality.yml` | markdownlint + REQ-ID traceability | When `**.md` or `.specs/` change |

Check failed runs in the Actions tab. Fix locally with `./scripts/check.sh`.

## Azure — Stage 4

Stage 4 is when the team applies Terraform to a sandbox subscription provided by the facilitators.

```bash
cd infra
terraform init
terraform plan -var-file=envs/dev/terraform.tfvars
terraform apply -var-file=envs/dev/terraform.tfvars
```

> Each team has a unique subscription quota. Tag every resource with `team=team-XX` or your apply will fail.

## Common problems

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `docker compose up` hangs | Port 5432 / 8080 / 3000 already used | `lsof -i :5432` and kill the process |
| `mvn verify` fails on Testcontainers | Docker not running | Start Docker Desktop |
| `pnpm test` fails on snapshots | Component changed intentionally | `pnpm test -- -u` to update |
| `terraform apply` rejected | Missing `team=` tag | Add tag to the failing resource |
| GitHub Actions can't reach Azure | OIDC subject claim mismatch | Re-run `az ad sp create-for-rbac` per team |

## When to escalate to a facilitator

- Build still failing after 20 minutes of debug.
- Azure subscription appears suspended.
- Anything irreversible (e.g., `terraform destroy` ran by mistake).

Use the 3-line escalation format from [TEAM-FLOW.md §4](../TEAM-FLOW.md).
