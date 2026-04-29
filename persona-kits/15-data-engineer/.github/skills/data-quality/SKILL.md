---
name: Data Quality
description: "Use when defining data quality rules, schema contracts, or SLA monitoring for a dataset. Triggers on 'data quality', 'great expectations', 'schema contract', 'data SLA', 'data validation', 'null check'."
---

# Data Quality

## When to invoke
- "Add data quality checks to this pipeline."
- "Define a schema contract for this dataset."
- "Our dashboard broke because upstream changed a column."

## The six dimensions
Every dataset should have explicit tests covering:
1. **Completeness** - expected rows present, no unexpected nulls.
2. **Uniqueness** - primary key actually unique.
3. **Validity** - values conform to type, range, regex, enum.
4. **Consistency** - cross-field rules (end_date ≥ start_date), cross-dataset (foreign keys resolve).
5. **Timeliness** - data arrived within its SLA.
6. **Accuracy** - spot checks against a source of truth (sampled).

## Workflow
1. **Write the contract first** - a YAML/JSON schema describing columns, types, constraints, freshness SLA, ownership.
2. **Enforce at boundaries** - validate on write into Silver, not only on read.
3. **Separate hard-fail from soft-warn**:
   - **Hard fail** → PK duplication, schema drift, missing partition → pipeline stops, pages on-call.
   - **Soft warn** → row count outside ±20% of rolling baseline → ticket, does not block.
4. **Quarantine bad rows**, don't drop them silently. Keep the rejection reason.
5. **Dashboard the SLA**: freshness, volume anomaly, failed-check rate by dataset.

## Tools
- **Great Expectations** / **Soda** - declarative tests, good for batch
- **dbt tests** - if you're in the dbt ecosystem
- **Deequ** / **PyDeequ** - Spark-native
- **Monte Carlo** / **Anomalo** - observability / anomaly detection layer on top

## Anti-patterns
- Checks only in production - learn at the worst time.
- No owner on the dataset - nobody fixes alerts.
- Warn-only checks forever - noise becomes ignored.
- Testing the *output* of a transform instead of the *input* - you've already corrupted downstream.

## References
- [Great Expectations - Core Concepts](https://docs.greatexpectations.io/docs/core/introduction/)
- [Data Contracts - Andrew Jones](https://data-contracts.com/)
- [Monte Carlo - Data Observability](https://www.montecarlodata.com/blog-what-is-data-observability/)
