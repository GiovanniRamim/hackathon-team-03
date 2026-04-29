---
mode: ask
model: claude-sonnet-4-6
description: "Generate SQL/KQL query for a business KPI"
---

# /kpi-query

## Task
Translate a business KPI request into an executable SQL or KQL query with the required data source, window, and filters clearly specified.

## Steps
1. Clarify the KPI definition with the user if ambiguous (e.g. "active users" → daily, weekly, monthly?).
2. Identify the data source (Azure Data Explorer / PostgreSQL / Application Insights) and the relevant table(s).
3. Write the query with: time window, filters, grouping, ordering, and row limit.
4. Provide a sample expected output shape (columns, row count estimate).
5. Note any data quality caveats (missing rows, deduplication, timezone).

## Output
- The query, in a fenced code block with the correct language tag
- One-paragraph interpretation of what the result means for the business
- A follow-up query suggestion for the next logical drill-down

## Quality Gate
- [ ] Query uses parameters, not hardcoded dates
- [ ] Time window and timezone are explicit
- [ ] Query runs in under 30 seconds on the target store (or is flagged as long-running)
- [ ] No sensitive columns exposed (PII, tokens) without a masking step
