---
mode: ask
model: claude-sonnet-4-6
description: "Validate an API implementation against its OpenAPI contract"
---

# /api-validate

## Task
Validate that an API implementation matches its OpenAPI/AsyncAPI contract and surface every drift.

## Steps
1. Load the contract (openapi.yaml / asyncapi.yaml) and the implementation (controllers, handlers).
2. For each operation in the contract, check: path, method, request schema, response schema, error codes, auth scheme.
3. For each endpoint in the implementation, check that it exists in the contract (detect undocumented endpoints).
4. Validate request/response schema with real examples if available.
5. Classify drift as: breaking (removes/changes field), additive (new optional field), metadata (description only).

## Output
Markdown table: `Endpoint | Drift Type | Severity | Fix Location (contract or code)`.

## Quality Gate
- [ ] Every contract operation is checked (100% coverage)
- [ ] Every implementation endpoint is checked against the contract
- [ ] Breaking drift is highlighted separately from additive drift
- [ ] The fix location (contract vs. code) is explicit for each item
