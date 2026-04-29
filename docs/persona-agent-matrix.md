---
title: "Persona × Agent Matrix"
description: "Full 10×4 mapping of how each persona interacts with each stage agent"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-29"
version: "1.0.0"
status: "approved"
tags: ["personas", "agents", "matrix", "roles", "hackathon"]
---

# Persona × Agent Matrix

This matrix maps every persona to every agent, showing who does what in each stage of the hackathon. Use it to understand your role at each point in the day.

**How to read this document:**

1. Find your persona row
2. Read across to see your intensity level at each stage
3. For stages where you are **PROTAGONIST** or **Secondary**, read the detailed guidance below
4. Open the agent kit README for the current stage to see the full workflow

## The Matrix

| # | Persona | @archaeologist | @architect | @builder | @evolution |
|---|---------|---------------|------------|----------|------------|
| 01 | Product Owner | Observer | Secondary | Observer | Secondary |
| 02 | Requirements Engineer | **PROTAGONIST** | Secondary | Observer | Observer |
| 03 | Enterprise Architect | Secondary | Secondary | Observer | Observer |
| 04 | Software Architect | Observer | **PROTAGONIST** | Secondary | Observer |
| 05 | Technical Lead | Observer | Secondary | Secondary | **PROTAGONIST** |
| 06 | Developer | Observer | Observer | **PROTAGONIST** | Secondary |
| 07 | DBA | Secondary | Observer | Secondary | Observer |
| 08 | QA Engineer | Observer | Observer | Secondary | Secondary |
| 09 | DevOps Engineer | Observer | Observer | Secondary | Secondary |
| 10 | Tech Writer | Secondary | Observer | Observer | Secondary |

**PROTAGONIST** = Drives the agent's use; owns the stage deliverables.
**Secondary** = Actively contributes; paired with the protagonist.
**Observer** = Follows along in chat; ready to help when their expertise is needed.

## Per-Cell Guidance

### Stage 1 — @archaeologist-agent

| Persona | What you do |
|---------|------------|
| **Requirements Engineer** (PROTAGONIST) | Drive the exploration. Open each Natural program, ask the agent to help you decode it, and capture business rules as draft requirements. You own the business-rule draft. |
| Tech Writer (Secondary) | Build the domain glossary in real time. Every time the team encounters a term — a variable name, a field label, a subroutine purpose — add it to the glossary with a definition. |
| Enterprise Architect (Secondary) | Focus on the big picture: what external systems does the legacy code call? What batch inputs come from where? Start sketching the system context. |
| DBA (Secondary) | Focus on the DDMs. Document field types, descriptors, MU/PE structures, and relationships between files. This becomes your data map. |
| Product Owner (Observer) | Listen and validate. When the team proposes a business rule interpretation, confirm or challenge it based on your domain understanding. |
| All others (Observer) | Follow the chat. When someone asks about a pattern in your expertise area (e.g., the Developer sees a calculation they recognize), speak up. |

### Stage 2 — @architect-agent

| Persona | What you do |
|---------|------------|
| **Software Architect** (PROTAGONIST) | Lead the bounded context carving. Use the data map and call graph from Stage 1 to identify natural boundaries. Draw C4 diagrams. Write the first ADRs. |
| Requirements Engineer (Secondary) | Transform Stage 1 business rules into formal EARS requirements with `REQ-NNN` IDs. Each requirement needs acceptance criteria. Work with the Software Architect to ensure requirements map to bounded contexts. |
| Enterprise Architect (Secondary) | Validate the system context diagram. Ensure integration points (batch feeds, external APIs, authentication) are captured. Review ADRs for architectural consistency. |
| Product Owner (Secondary) | Prioritize requirements. With limited time, the team cannot implement everything. Help decide which requirements are must-have vs. nice-to-have. |
| Technical Lead (Observer) | Start thinking about implementation order. Which bounded context should the team build first? What are the dependencies? |
| All others (Observer) | Review the emerging specification. Flag anything that looks incomplete or inconsistent from your perspective. |

### Stage 3 — @builder-agent

| Persona | What you do |
|---------|------------|
| **Developer** (PROTAGONIST) | Write code. Use the builder agent to generate JPA entities, Spring services, REST controllers, and Next.js pages. Every piece of code traces to a `REQ-NNN`. |
| DBA (Secondary) | Own the database layer. Review entity mappings, write Flyway migrations, validate that the PostgreSQL schema correctly represents the data model from Stage 2. |
| QA Engineer (Secondary) | Write tests alongside the Developer. For every service, produce at least one happy-path and one error-path test. Monitor coverage and flag gaps. |
| Technical Lead (Secondary) | Review code as it is produced. Check for standards violations (no `@Autowired` fields, no `null` returns, no `any` in TypeScript). Merge PRs. |
| Software Architect (Secondary) | Validate that the implementation matches the design. If the Developer is deviating from the bounded context boundaries, flag it early. |
| All others (Observer) | Available for questions. The Developer may need domain clarification that only the Product Owner or Requirements Engineer can provide. |

### Stage 4 — @evolution-agent

| Persona | What you do |
|---------|------------|
| **Technical Lead** (PROTAGONIST) | Write GitHub Issues for Copilot Agent to execute. Review AI-generated PRs. Decide what to merge and what to reject. Own integration and demo readiness. |
| DevOps Engineer (Secondary) | Write the GitHub Actions workflow and Terraform modules. Ensure proper tagging, secret management, and resource configuration. |
| QA Engineer (Secondary) | Validate that the CI pipeline includes all quality gates: lint, build, test. Review test results from AI-generated PRs. |
| Developer (Secondary) | Review AI-generated code for correctness. You know the codebase best — spot logical errors that automated checks might miss. |
| Tech Writer (Secondary) | Polish the README, document the demo script, and ensure the retrospective notes capture the team's learnings. |
| Product Owner (Secondary) | Help prioritize what must work for the demo vs. what can be deferred. Prepare the narrative for the 3-minute presentation. |
| All others (Observer) | Contribute retrospective observations. What surprised you? What would you do differently? |

## Reading Order Suggestion

1. Read your **persona card** in [`personas/`](../personas/) — understand what you own
2. Read your **row in this matrix** — understand your intensity at each stage
3. When a new stage begins, open the **agent kit README** for that stage in [`agent-kits/`](../agent-kits/)
4. Activate the **chatmode** for the current stage and begin working

## References

- Agent kits: [`agent-kits/`](../agent-kits/README.md)
- Agent architecture: [`docs/4-agents-explained.md`](4-agents-explained.md)
- Persona cards: [`personas/`](../personas/)
- Persona Copilot kits: [`persona-kits/`](../persona-kits/)

---

| Previous | Home | Next |
|----------|------|------|
| [Docs Home](README.md) | [Team Kit Home](../README.md) | [4 Agents Explained](4-agents-explained.md) |
