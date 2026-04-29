---
name: Safe Schema Migration
description: "Use when planning an online schema change, zero-downtime migration, or rolling back a deploy that changed a table. Triggers on 'migration', 'ALTER TABLE', 'zero-downtime', 'expand-contract', 'backfill'."
---

# Safe Schema Migration

## When to invoke
- "Plan the migration for adding column X."
- "Can we rename this column without downtime?"
- "How do we drop this table safely?"

## Expand / migrate / contract pattern
Every schema change that touches live traffic goes in **three deploys**, never one.

1. **Expand** - add the new shape alongside the old (new column nullable, new table, new index). No reads/writes use it yet.
2. **Migrate** - dual-write to old and new, backfill historical rows, switch reads to the new shape behind a flag.
3. **Contract** - remove the old shape only after the new shape has been authoritative for at least one release cycle.

## Rules of thumb
- **Additive is always safe**: new nullable column, new index (CONCURRENTLY / ONLINE), new table.
- **Destructive is never one deploy**: drop column, rename column, change type, drop table, NOT NULL add.
- **Backfills run in batches** with a LIMIT, sleep between batches, idempotent. Never `UPDATE whole_table SET …` in one shot.
- **Index builds**: `CREATE INDEX CONCURRENTLY` (Postgres), `ONLINE=ON` (MySQL 8 / SQL Server). Watch for lock escalation.
- **Renames**: do NOT rename in place. Add new column → dual-write → backfill → switch reads → drop old.

## Pre-flight checklist
- [ ] Migration has a written **forward** and **rollback** plan.
- [ ] Estimated duration on a **copy of production** (never estimate on dev).
- [ ] Lock impact assessed (`pg_locks`, `SHOW ENGINE INNODB STATUS`, `sys.dm_tran_locks`).
- [ ] Backfill batch size chosen based on replication lag budget.
- [ ] Monitoring in place for replica lag, long transactions, deadlocks.
- [ ] Feature flag or dual-read path in place before migrate step.

## Red flags - do not ship
- Single `ALTER TABLE` that takes a full lock on a large table.
- Migration coupled to application deploy (cannot roll back independently).
- Irreversible step with no backup.
- Backfill that rewrites every row in one transaction.

## References
- [Braintree - PostgreSQL at Scale: Safe Migrations](https://medium.com/paypal-tech/postgresql-at-scale-database-schema-changes-without-downtime-20d3749ed680)
- [GitHub - gh-ost online schema migration](https://github.com/github/gh-ost)
- [Martin Fowler - Evolutionary Database Design](https://martinfowler.com/articles/evodb.html)
