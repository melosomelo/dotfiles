---
name: user-story
description: >-
  Transforms informal feature descriptions into structured user stories with
  Given/When/Then acceptance criteria, Gherkin BDD scenarios, Out of Scope, Test
  Coverage Suggestions, and Open Questions for the Sterk quality plan. Complements
  the spec-driven Specify phase and feeds the test-creation workflow. Use when
  writing user stories, generating US-NN from a feature spec, refining stories for
  a sprint, or when user says "write user story", "generate US", "create user
  stories", "user stories for this feature", "US from spec", or "story-ready".
---

# User Story Writing

Transforms informal feature descriptions into formal, precise, sprint-ready
artifacts for development and QA. Complements the [spec-driven](../spec-driven/SKILL.md)
Specify phase — runs after `spec.md` exists (or from conversation when no spec
exists yet) and before Tasks are broken down.

Artifacts feed directly into test creation; precision here improves generated tests.

**Reference material** (read on demand — see [template.md](references/template.md) index):

| File | When |
| --- | --- |
| [inputs.md](references/inputs.md) | Step 1 — gathering source material |
| [reasoning-sequence.md](references/reasoning-sequence.md) | Step 2 — **MUST read** before drafting |
| [output-format.md](references/output-format.md) | Step 3 — **MUST read** before writing |
| [spec-writeback.md](references/spec-writeback.md) | Step 5 — **MUST read** before editing `spec.md` |
| [quality-rules.md](references/quality-rules.md) | Step 4 — validate while drafting |
| [anti-patterns.md](references/anti-patterns.md) | Step 4 — review and fix gaps |

---

## Permissions on `spec.md`

> **This skill may edit only the `## User Stories` section in `spec.md` — nothing else.**

| Allowed | Forbidden |
| --- | --- |
| Replace body of `## User Stories` with the index table ([spec-writeback.md](references/spec-writeback.md)) | Problem Statement, Goals, Out of Scope |
| Insert `## User Stories` if missing (index table only) | `## Requirements`, Edge Cases, Decisions Log |
| | Requirement Traceability table or Story column |
| | Success Criteria, architecture notes, header fields (`**Extends**`, `**Milestone**`, etc.) |

Requirement IDs and `WHEN/THEN/SHALL` contract text stay in `spec.md` under
`## Requirements` — owned by the **Specify** phase ([specify.md](../spec-driven/references/specify.md)),
not this skill.

---

## Layer model (Option A)

| Layer | Owner | Location |
| --- | --- | --- |
| Contract (`WHEN/THEN/SHALL` + IDs) | spec-driven Specify | `spec.md` → `## Requirements` |
| US index (summary + links) | **user-story** (this skill) | `spec.md` → `## User Stories` |
| Elaboration (Given/When/Then, context) | **user-story** | `user-stories.md` |
| Proof (Gherkin + tags) | gherkin-acceptance | `acceptance/*.feature` |

---

## When to invoke

| Input available | This skill does |
| --- | --- |
| `spec.md` exists (spec-driven Specify done) | Derives one US per distinct user goal from requirement IDs |
| Feature described in conversation (no spec yet) | Writes stories from stated requirements; flags unknowns as Open Questions |
| Existing stories need review | Applies the quick check; load [anti-patterns.md](references/anti-patterns.md) |

---

## Six-step workflow

1. **Gather inputs** — Read [inputs.md](references/inputs.md). Load
   `.specs/features/[feature]/spec.md` when it exists (read-only except step 5).
2. **Reason** — Follow [reasoning-sequence.md](references/reasoning-sequence.md)
   internally. Do not output these steps in the artefact.
3. **Draft** — One `US-NN` per distinct goal. Write using
   [output-format.md](references/output-format.md) exactly.
4. **Validate** — Apply [quality-rules.md](references/quality-rules.md). Fix
   issues flagged in [anti-patterns.md](references/anti-patterns.md).
5. **Emit stories** — Write `.specs/features/[feature]/user-stories.md`.
6. **Write back index** — Read [spec-writeback.md](references/spec-writeback.md).
   Replace **only** `## User Stories` in `spec.md` with the index table. Run
   quick check below.

---

## Artefact location

| Artefact | Path |
| --- | --- |
| User stories (canonical detail) | `.specs/features/[feature]/user-stories.md` |
| US index in spec | `.specs/features/[feature]/spec.md` → `## User Stories` only |
| Requirements contract | `.specs/features/[feature]/spec.md` → `## Requirements` (Specify — read-only here) |
| Gherkin scenarios (Large/Complex) | `.specs/features/[feature]/acceptance/[story-slug].feature` |

The Specify phase adds `**User Stories**: [user-stories.md](…)` in the spec
header when appropriate. This skill does not edit spec header metadata.

---

## Quick check before marking a story ready

- [ ] Intention (why) clear and separate from implementation (how)?
- [ ] Happy path, main errors, and at least one edge case in Acceptance Criteria?
- [ ] Each AC states a concrete, measurable expected result?
- [ ] BDD section: embedded Gherkin **or** pointer to `acceptance/*.feature` — never both?
- [ ] If embedded Gherkin: exactly one `When` per `Scenario`?
- [ ] If pointer mode: linked `.feature` file exists and covers this story's AC?
- [ ] Out of Scope filled (never blank)?
- [ ] Test Coverage Suggestions lists priority scenarios for the test agent?
- [ ] All assumptions sourced from spec or user — unknowns in Open Questions?
- [ ] Single goal per story (not compound)?
- [ ] `spec.md` `## User Stories` is index table only — no other spec sections edited?

Full validation detail: [quality-rules.md](references/quality-rules.md).

---

## Skill integrations

- **Invoked after** [spec-driven](../spec-driven/SKILL.md) Specify phase (`## Requirements` must exist).
- **Delegates** standalone `.feature` authoring and proof methods to
  [gherkin-acceptance](../gherkin-acceptance/SKILL.md). When `.feature` files
  exist, they are the **canonical Gherkin** — `user-stories.md` links to them
  instead of embedding duplicate scenarios (see [output-format.md](references/output-format.md)).
- **Feeds** test-creation workflows via **Test Coverage Suggestions**.
- **Does not** replace `## Requirements` in `spec.md`, edit traceability, create tasks, or implement features.
