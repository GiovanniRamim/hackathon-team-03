---
name: Pipeline Design
description: "Use when designing a new data pipeline, choosing between batch and streaming, or laying out a medallion / lakehouse architecture. Triggers on 'data pipeline', 'ETL', 'ELT', 'medallion', 'bronze silver gold', 'streaming vs batch'."
---

# Pipeline Design

## When to invoke
- "Design a pipeline for ingesting X into our warehouse."
- "Batch or streaming?"
- "Bronze / Silver / Gold - how do we split this?"

## Decision: batch vs streaming
Pick **batch** unless you have a specific reason not to. Batch is simpler, cheaper, easier to reprocess.

Choose **streaming** only when:
- Business requirement needs <1 min freshness.
- Windowed aggregations or CDC-driven state are core to the product.
- Team has operational maturity for Kafka / Flink / Kinesis.

Everything else: scheduled batch (hourly, every 15 min) with micro-batching if you need freshness.

## Medallion layering
- **Bronze (raw)** - append-only, immutable, source schema preserved. Never deleted.
- **Silver (cleansed)** - deduped, typed, conformed dimensions, referential integrity. One row per logical entity state.
- **Gold (curated)** - business-ready marts, denormalized, optimized for consumption (dashboards, ML features).

Each layer has its own SLA, schema contract, and owner.

## Design checklist
- [ ] **Idempotent** - rerunning a job produces identical output (deterministic keys, upserts, not appends).
- [ ] **Partitioned** by the column you most often filter by (usually ingestion date).
- [ ] **Backfill-safe** - can reprocess a past date range without corrupting downstream.
- [ ] **Late-arriving data** strategy documented (watermark, SCD Type 2, or full reprocess window).
- [ ] **Schema evolution** strategy (Avro/Parquet schema registry, not free-form JSON).
- [ ] **Dead-letter queue** for bad records, with alerting when it fills.
- [ ] **Lineage** captured (OpenLineage / dbt docs / Unity Catalog).

## Anti-patterns
- Mixing business logic into Bronze - that defeats the replay safety net.
- No partition key - full-table scans every run.
- "We'll fix the schema later" - you won't.
- One giant DAG - split by domain, keep each DAG under ~30 tasks.

## References
- [Databricks - Medallion Architecture](https://www.databricks.com/glossary/medallion-architecture)
- [Martin Kleppmann - Designing Data-Intensive Applications](https://dataintensive.net/)
- [dbt - Best Practices](https://docs.getdbt.com/best-practices)
