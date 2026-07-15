# Inputs

Gather from `spec.md`, conversation, or explicit user fields before writing.

| Input | Required | Purpose |
| --- | --- | --- |
| **description** | yes | Free-form feature description |
| **end_user** | yes | Who uses it and with what objective |
| **business_rules** | no | Existing rules that must be respected |
| **constraints** | no | Known technical constraints |
| **glossary** | no | Domain-specific terminology |
| **examples** | no | Informal examples of expected behavior |

## Sourcing rules

1. **Load `spec.md` first** when `.specs/features/[feature]/spec.md` exists (read-only except `## User Stories` writeback — see [spec-writeback.md](spec-writeback.md)).
2. **Map spec sections** to inputs:
   - `## Requirements` + traceability → `description`, requirement IDs
   - Legacy full user story blocks (if present) → `end_user` until writeback replaces them
   - Edge cases → `examples`
   - Constraints from design/spec notes → `constraints`
3. **Never invent business rules** not present in the spec, inputs, or explicit user statement.
4. **Gaps become Open Questions** — not silent assumptions in the story body.

## Option A — spec vs user-stories split

| Read from `spec.md` | Write to `user-stories.md` |
| --- | --- |
| `## Requirements` (`WHEN/THEN/SHALL` contract) | Given/When/Then **elaboration** (same intent, more testable detail) |
| Requirement IDs, priorities | `US-NN` mapping in overview table |
| Feature-level out of scope | Per-story Out of Scope where narrower |

Do not copy `WHEN/THEN/SHALL` lines verbatim into AC bullets — **elaborate** them into Given/When/Then without changing intent.

## When `spec.md` is absent

Use conversation context and ask the user only for missing **required** inputs (`description`, `end_user`) before drafting. Flag everything else as Open Questions until confirmed.
