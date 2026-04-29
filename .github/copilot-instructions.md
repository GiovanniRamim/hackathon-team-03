# GitHub Copilot Instructions - Hackathon DATACORP 2026

## Project Context

This repository is part of the **Hackathon DATACORP 2026 - Agentic DevOps Platform**.  
You are modernizing the **SIFAP** system (Social Benefits Payment System) from Natural/Adabas to a modern stack.

## Target Stack

- **Backend:** Java 21 + Spring Boot 3.3 + JPA/Hibernate + PostgreSQL 16
- **Frontend:** Next.js 15 (App Router) + TypeScript + Tailwind CSS + shadcn/ui
- **Containers:** Docker + Docker Compose
- **IaC:** Terraform for Azure
- **CI/CD:** GitHub Actions

## Code Generation Rules

- Always use Java 21 features (records, sealed classes, pattern matching)
- RESTful APIs follow convention: `/api/v1/{resource}`
- Class names in English, comments in English
- Unit tests mandatory for business logic
- Never expose sensitive data (CPF, benefit amounts) in logs

## Active Personas on This Team

<!-- TODO: Each team fills in the 10 active personas here -->
- [ ] Product Owner
- [ ] Requirements Engineer
- [ ] Enterprise Architect
- [ ] Software Architect
- [ ] Technical Lead
- [ ] Developer
- [ ] DBA
- [ ] QA Engineer
- [ ] DevOps Engineer
- [ ] Tech Writer

## How to Use Copilot

1. **Chat** - to explore legacy and plan
2. **Edits** - to implement multi-file changes
3. **Agent** - for complete autonomous features

## References

- [Specky SDD Plugin](https://github.com/paulasilvatech/specky)
- [SIFAP Legacy](https://github.com/paulasilvatech/sifap-legacy)
- **Reference SIFAP 2.0 Spec** (shared by facilitators)
