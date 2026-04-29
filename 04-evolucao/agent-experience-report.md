---
title: "Agent Experience Report"
description: "Lessons learned using GitHub Copilot Agent in SIFAP modernization"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.1.0"
status: "approved"
tags: ["stage-4", "copilot", "agent", "experience", "lessons-learned"]
---

# 🤖 GitHub Copilot Agent Experience Report

> Captures the team's experience using GitHub Copilot, Copilot CLI, and Agent tools throughout the SIFAP 2.0 modernization hackathon.

---

## 📑 Table of Contents

1. [📌 Overview](#overview)
2. [🏛️ Stage 1 - Archaeology (Copilot Chat)](#stage-1-archaeology-copilot-chat)
3. [📋 Stage 2 - Specification (Copilot + Specky SDD)](#stage-2-specification-copilot-specky-sdd)
4. [🛠️ Stage 3 - Implementation (Copilot + GitHub Copilot Agent)](#stage-3-implementation-copilot-github-copilot-agent)
5. [🚀 Stage 4 - Evolution (Copilot for IaC and CI/CD)](#stage-4-evolution-copilot-for-iac-and-cicd)
6. [⚖️ Copilot vs. Specky SDD Tool](#copilot-vs-specky-sdd-tool)
7. [📈 Team Productivity Impact](#team-productivity-impact)
8. [💡 Recommended Copilot Practices](#recommended-copilot-practices)
9. [❌ What Didn't Work](#what-didnt-work)
10. [🎓 Lessons Learned](#lessons-learned)
11. [💡 Recommendations for Future Projects](#recommendations-for-future-projects)
12. [🎯 Conclusion](#conclusion)
13. [📎 Appendix: Useful Copilot Prompts](#appendix-useful-copilot-prompts)

---

---

## 📌 Overview

This document captures the team's experience using GitHub Copilot, GitHub Copilot CLI, and GitHub Copilot Agent tools throughout the SIFAP 2.0 modernization hackathon. Purpose: Inform best practices for future Copilot-driven development.

---

## 🏛️ Stage 1 - Archaeology (Copilot Chat)

### What We Used

- **GitHub Copilot Chat** in VS Code
- Prompts for code analysis and business rule extraction

### What Worked Well

1. **Code summarization**: Pasting a Natural program and asking "Explain this business logic in plain English" took 30 seconds instead of 15 minutes of manual reading.
   
   **Example prompt**: 
   ```
   I have this Natural program [paste code]. 
   What business rules does it enforce? 
   List them as bullet points.
   ```

2. **Pattern recognition**: Copilot spotted that CALCDSCT program had multiple discount types despite sparse documentation.

3. **Quick fact-checking**: "Is modulo-11 the correct CPF validation algorithm used in Brazil?" - Instant confirmation without web search.

### Challenges

1. **Hallucination on legacy systems**: Copilot sometimes suggested improvements or alternatives that don't exist in Natural/Adabas. Had to validate against actual code.

2. **Large code blocks**: Pasting entire programs (500+ lines) sometimes resulted in incomplete analysis. Better to paste smaller functions.

3. **Domain terminology confusion**: Copilot occasionally confused Portuguese acronyms (CPMF vs. IRPF) until we provided glossary context.

### Recommendations for Stage 1

- **Provide context first**: Give Copilot the glossary before asking questions about domain terms.
- **Break code into smaller chunks**: Don't paste entire programs; paste functions one at a time.
- **Use system prompts**: If using Copilot CLI, set a custom system prompt that explains Brazilian government terminology.

---

## 📋 Stage 2 - Specification (Copilot + Specky SDD)

### What We Used

- **GitHub Copilot Chat** for EARS requirement drafting
- **Specky SDD tool** (`sdd_write_spec`) for structured template generation
- Manual refinement in markdown

### What Worked Well

1. **EARS pattern validation**: Copilot correctly identified when a requirement didn't follow EARS syntax and suggested fixes.

   **Example**: 
   - Input: "The system should calculate discounts"
   - Copilot: "This is incomplete. Try: 'When calculating payment, the system shall apply all discount rules.'"

2. **Acceptance criteria generation**: Asking "Generate Given/When/Then acceptance criteria for this requirement" produced 3 solid test cases.

3. **Traceability mapping**: Copilot helped create the REQ -> BR mapping table quickly.

### Challenges

1. **Over-specification**: Copilot sometimes created 5 acceptance criteria per requirement when 2-3 was sufficient. Manual review needed.

2. **Technology assumptions**: When drafting non-functional requirements, Copilot defaulted to Azure/cloud best practices even though SIFAP had specific constraints.

3. **Legacy rule interpretation**: Translating legacy business rules to modern EARS patterns required human judgment. Copilot couldn't make these decisions autonomously.

### Recommendations for Stage 2

- **Use Copilot for drafting, not final spec**: Have Copilot generate first draft, then team reviews and refines.
- **Provide business context**: "We're modernizing a 2015 government benefits system..." helps Copilot understand constraints.
- **Validate acceptance criteria manually**: Every acceptance criterion should be reviewed by QA to ensure testability.

---

## 🛠️ Stage 3 - Implementation (Copilot + GitHub Copilot Agent)

### What We Used

- **GitHub Copilot in VS Code** for code completion
- **GitHub Copilot Agent** (via CLI) for autonomous implementation tasks
- **GitHub Copilot Chat** for debugging and refactoring

### What Worked Well

1. **Test-first generation**: Asking "Generate unit tests for this service" and then using test suggestions to guide implementation was faster than TDD written manually.

   **Time saved**: 30% faster than manual TDD.

2. **Boilerplate code**: Spring Boot controller scaffolding, JPA entity generation, and OpenAPI annotations - Copilot did this faster than typing manually.

3. **Error resolution**: Pasting stack traces into Copilot Chat and asking "Why is this happening?" often yielded correct diagnosis and fix suggestions.

   **Success rate**: 70% of suggestions were correct or required minimal adjustment.

### Challenges

1. **Architectural consistency**: Copilot sometimes generated code that didn't follow the team's architecture patterns (e.g., business logic in controller instead of service layer).

   **Mitigation**: Established a `.gpt-architect` prompt file describing the team's patterns.

2. **Test coverage**: Copilot-generated tests were sometimes superficial (testing happy path only, not edge cases).

   **Mitigation**: Manual review of all tests; QA added edge case tests.

3. **TypeScript strictness**: Frontend code often had `any` types or non-null assertions that violated strict mode.

   **Mitigation**: Post-generation linting with `npm run lint --fix`.

### Agent Autonomy Experience

**Question**: Could GitHub Copilot Agent autonomously implement a user story?

**Answer**: Partially. For simple stories (single CRUD endpoint), yes. For complex features with multiple components and integration points, no - it needed guidance.

**Examples**:
- ✅ Autopilot: "Implement POST /api/beneficiaries endpoint" - Generated 80% correct code
- ❌ Manual needed: "Implement payment calculation with discount rules" - Required 3 iterations, human reviewing at each step

### Recommendations for Stage 3

- **Use Copilot Agent for scaffolding, not business logic**: Autopilot works for boilerplate; keep complex logic under human control.
- **Establish architectural guide**: Create a `.gpt-architect` file documenting team patterns before Copilot generates code.
- **Mandate code review**: Every Copilot-generated code block must be reviewed by a human before merging.
- **Pair programming**: Best results when developer and Copilot work together; not optimal for fully autonomous generation.

---

## 🚀 Stage 4 - Evolution (Copilot for IaC and CI/CD)

### What We Used

- **GitHub Copilot Chat** for Terraform generation
- **GitHub Copilot in VS Code** for GitHub Actions workflow suggestions
- Manual validation and testing

### What Worked Well

1. **Terraform module scaffolding**: "Generate a Terraform module for Azure App Service" produced ~70% of the required code.

2. **GitHub Actions workflow templates**: Asking "Generate a CI/CD workflow that builds, tests, and deploys to Azure" gave a solid starting point.

3. **Security best practices**: Copilot correctly suggested using Azure Key Vault for secrets instead of environment variables.

### Challenges

1. **Terraform state management**: Copilot didn't always configure remote backend correctly.

2. **Azure authentication**: Generated workflows sometimes used hardcoded subscription IDs instead of variables.

3. **Error handling in scripts**: GitHub Actions error handling in Copilot suggestions was often incomplete.

### Recommendations for Stage 4

- **Validate IaC before deployment**: Always run `terraform validate` and `terraform plan` before applying.
- **Test in dev first**: Deploy to dev environment and verify, then promote to prod.
- **Use GitHub branch protection**: Require human approval before merging IaC changes to main branch.

---

## ⚖️ Copilot vs. Specky SDD Tool

### Comparison

| Task | GitHub Copilot | Specky SDD | Better Choice |
|------|---|---|---|
| Extract business rules from legacy code | Fast (~5 min per program) | Not designed for this | Copilot |
| Generate EARS requirements | Fast but needs review (~2 min per REQ) | Slow but structured (~5 min per REQ) | Copilot for drafting |
| Validate EARS patterns | Good (~70% accurate) | Excellent (built-in validation) | Specky for validation |
| Generate architecture decisions | Good context (~10 min) | Not designed for this | Copilot |
| Generate test stubs | Excellent (~2 min per file) | Good (~3 min per file) | Copilot or Specky |
| Trace requirements to code | Poor (manual) | Good (~1 min per trace) | Specky |
| Generate infrastructure code | Good (~70% correct) | Not designed for this | Copilot |

**Conclusion**: Use Copilot for fast drafting and code generation. Use Specky SDD for structured artifacts and traceability.

---

## 📈 Team Productivity Impact

### Metrics

| Activity | Without Copilot | With Copilot | Time Saved |
|---|---|---|---|
| Code natural program analysis | 15 min/program | 5 min/program | 67% |
| EARS requirement drafting | 10 min/REQ | 2 min/REQ | 80% |
| Unit test generation | 30 min/module | 10 min/module | 67% |
| Controller scaffolding | 20 min/controller | 3 min/controller | 85% |
| Terraform module writing | 45 min/module | 15 min/module | 67% |
| GitHub Actions workflow writing | 30 min/workflow | 10 min/workflow | 67% |

**Overall productivity gain**: Estimated 60-70% time savings for routine coding tasks.

**Caveats**:
- Savings assume competent human review; bad review can negate gains
- Complex business logic still requires significant human thinking
- Code quality varies; Copilot-generated code needs testing

---

## 💡 Recommended Copilot Practices

### General

1. **Verify before trusting**: Copilot is fast but not always correct. Always review output.
2. **Use system prompts**: Set context (project details, architectural patterns) before asking questions.
3. **Break down tasks**: Smaller, more specific prompts yield better results than large vague prompts.
4. **Iterate**: First draft is rarely perfect; refine with follow-up prompts.

### Specific to SIFAP

1. **Provide glossary**: Include Portuguese/English domain term mappings in system prompt.
2. **Establish patterns**: Create `.gpt-architect` describing team's architecture decisions.
3. **Mandate code review**: Never merge Copilot-generated code without human review.
4. **Test thoroughly**: Copilot-generated code should have 80%+ test coverage.

---

## ❌ What Didn't Work

### Copilot Attempting to Modernize Legacy Code

**Issue**: Asking Copilot to "refactor this Natural program to Java" or "rewrite this in modern style" often resulted in incorrect business logic.

**Reason**: Copilot doesn't understand Natural/Adabas deeply; it made assumptions.

**Solution**: Use Copilot for understanding (analysis) not transformation. Humans do the actual modernization.

---

### Copilot Writing Complex Business Rules

**Issue**: Discount calculation, payment reversal logic, and edge cases often had subtle bugs when generated by Copilot alone.

**Reason**: Complex business logic requires domain knowledge and edge case testing.

**Solution**: Copilot generates scaffold; human implements business logic; Copilot generates tests.

---

### Copilot Managing State Machines

**Issue**: Beneficiary status lifecycle (ACTIVE -> SUSPENDED -> CANCELLED) was hard for Copilot to get right without explicit guidance.

**Solution**: Define state machines explicitly before asking Copilot to generate code.

---

## 🎓 Lessons Learned

### 1. Copilot is a Multiplier, Not a Replacement

Copilot makes good developers better (2x productivity). It doesn't make bad developers into good ones. It's a tool that requires skill to use well.

### 2. Prompting is a Skill

"Generate code for this" works okay. "Generate a Java service that validates CPF using modulo-11 and handles these 5 error cases" works much better. Investment in prompt engineering pays off.

### 3. Review and Testing are Mandatory

Copilot can produce incorrect code confidently. Human review and testing are not optional; they're essential.

### 4. Copilot + Human Judgment > Copilot Alone

Best results came when humans and Copilot worked together:
- Human: "Here's the requirement and why it exists"
- Copilot: "Here's a draft implementation"
- Human: "Here's my feedback and edge cases"
- Copilot: "Here's the updated implementation"

### 5. Specky SDD + Copilot is a Powerful Combination

Specky enforces structure (EARS patterns, traceability). Copilot is fast at drafting. Together they produce high-quality specs faster.

---

## 💡 Recommendations for Future Projects

1. **Train team on Copilot best practices**: Provide prompt engineering guidelines before starting.

2. **Establish code review standards**: Every Copilot-generated code block needs review. Don't trust it automatically.

3. **Invest in linting and testing**: Make CI pipeline strict. Copilot code often violates linting rules.

4. **Use Specky SDD early**: High-quality specifications make Copilot more effective.

5. **Measure productivity gains**: Track time spent on routine tasks vs. complex problem-solving. Copilot saves time on routine tasks.

---

## 🎯 Conclusion

GitHub Copilot significantly accelerated SIFAP 2.0 modernization, estimated 60-70% time savings on routine coding. Best practices:

- Use Copilot for drafting and scaffolding
- Mandate human review and testing
- Provide clear context and architectural guidance
- Combine with Specky SDD for structured artifacts

Copilot is not a replacement for skilled developers, but it is a powerful force multiplier when used properly.

---

## 📎 Appendix: Useful Copilot Prompts

### For Code Analysis

```
I have this [Natural/Python/Java] program [paste code]. 
What business logic does it enforce?
List business rules as: BR-NNN: [Rule description]
```

### For EARS Requirements

```
Based on this business rule: [BR description]
Generate 3 EARS requirements in different patterns:
1. Ubiquitous pattern
2. Event-driven pattern
3. Optional pattern

For each, include 2 acceptance criteria in Given/When/Then format.
```

### For Test Generation

```
I have this Java service:
[paste service code]

Generate comprehensive unit tests using JUnit 5 and Mockito.
Include happy path, error cases, and edge cases.
Aim for 80%+ code coverage.
```

### For Terraform

```
I need to deploy a Java Spring Boot application to Azure.
Generate a Terraform module that includes:
- App Service Plan and App Service
- PostgreSQL Flexible Server
- Key Vault for secrets
- Application Insights

Use variables for configurable values.
Include tags for resource management.
```

### For GitHub Actions

```
Generate a GitHub Actions workflow that:
1. Builds Java 21 project with Maven
2. Runs unit tests
3. Builds Next.js frontend
4. Deploys to Azure staging environment on PR
5. Deploys to production on merge to main

Include environment secrets for Azure credentials.
```

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Stage Guide](GUIDE.md) | [Kit Home](../README.md) | [Cheat Sheets →](../cheat-sheets/README.md) |
