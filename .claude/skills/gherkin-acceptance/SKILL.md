---
name: gherkin-acceptance
description: >-
  Writes testable Gherkin acceptance criteria (Given/When/Then) with
  requirement traceability and proof methods for manual UAT, automated gate, or
  Playwright. Use when specifying features, writing acceptance criteria, creating
  Done-when proof for tasks, or validating work. Invoke from spec-driven Specify,
  Tasks, or Validate phases. Triggers on "gherkin", "acceptance criteria", "BDD",
  "scenarios", "Cucumber", "feature file", "acceptance tests".
---

# Gherkin Acceptance Criteria

Expand `WHEN/THEN/SHALL` criteria from [spec-driven](../spec-driven/SKILL.md) into verifiable Gherkin scenarios. **Do not replace** the contract in `spec.md` — add executable proof on top of it.

**Reference material** (read on demand):

- [gherkin-primer.md](references/gherkin-primer.md) — syntax and step rules
- [spec-driven-integration.md](references/spec-driven-integration.md) — phase handoffs and mapping table
- [proof-methods.md](references/proof-methods.md) — how to prove each scenario
- [anti-patterns.md](references/anti-patterns.md) — what to avoid

---

## When to invoke

| spec-driven phase | This skill does |
| --- | --- |
| **Specify** | After user stories + `WHEN/THEN/SHALL` are written, expand P1 (and P2 when requested) into `.feature` scenarios |
| **Tasks** | Derive `Done when` items and proof method from scenarios; link tasks to `@REQ-ID` tags |
| **Validate** | Run scenarios as UAT roteiro; record PASS/FAIL per scenario and requirement ID |
| **Quick mode** | Optional: 0–1 inline scenario in `TASK.md` when scope is tiny |

Load `.specs/features/[feature]/spec.md` first. Load `.specs/codebase/TESTING.md` when assigning gate or E2E proof methods.

---

## Six-step workflow

1. **Read spec** — User stories, acceptance criteria, edge cases, requirement IDs from `spec.md`.
2. **Validate testability** — Each `WHEN/THEN/SHALL` must describe an observable outcome. If not, rewrite the criterion in `spec.md` (or flag for user) before writing Gherkin.
3. **Extract steps** — Actor + context → **Given**; trigger → **When**; observable result → **Then**.
4. **Write Gherkin** — One or more `.feature` files under `.specs/features/[feature]/acceptance/`. Tag with `@P1` / `@P2` and `@[REQ-ID]`.
5. **Assign proof method** — Per scenario: Manual UAT, Gate, E2E Playwright, or Inspection (see [proof-methods.md](references/proof-methods.md)).
6. **Emit artefacts** — `.feature` file(s), mapping table, and pointers in `spec.md` / `tasks.md` / validation report as appropriate.

**Output mapping table** (required after every `.feature` batch):

| Req ID | WHEN/THEN (spec) | Scenario title | Proof method |
| --- | --- | --- | --- |
| `[ID]` | [criterion summary] | [Scenario name] | [Manual UAT / Gate / E2E / Inspection] |

---

## Auto-sizing

Match depth to spec-driven scope — do not over-write Gherkin for trivial changes.

| spec-driven scope | Gherkin depth |
| --- | --- |
| **Quick** (≤3 files) | 0–1 scenario inline in `.specs/quick/NNN-slug/TASK.md`; no `.feature` file unless user asks |
| **Medium** | One scenario per P1 acceptance criterion; no `Scenario Outline` unless obvious variants |
| **Large / Complex** | `.feature` per user story or `Rule` block; `Background` for shared setup; `Scenario Outline` for edge-case matrices |

---

## Artefact locations

| Artefact | Path |
| --- | --- |
| Feature scenarios | `.specs/features/[feature]/acceptance/[story-slug].feature` |
| Contract (unchanged) | `.specs/features/[feature]/spec.md` |
| Task proof | `.specs/features/[feature]/tasks.md` → `Done when` |
| Validation roteiro | Validation report per [validate.md](../spec-driven/references/validate.md) |

**Link from spec.md** (after writing scenarios):

```markdown
**Gherkin**: `.specs/features/[feature]/acceptance/[story-slug].feature`
```

One `.feature` file = one `Feature:` keyword. Split by user story or business rule when stories grow large.

---

## Scenario tagging

- **Priority**: `@P1`, `@P2`, `@P3` — align with spec user story priority.
- **Requirement**: `@NOTIF-01`, `@AUTH-03` — one or more IDs per scenario when it proves that requirement.
- **Edge case**: `@edge` — optional, for criteria from the Edge Cases section.

Place tags on the line above `Feature:` or `Scenario:`.

Example:

```gherkin
@P1 @NOTIF-01
Feature: Configure role-based notification recipients

  Rule: Admin can define recipient rule types

    Background:
      Given a form admin is logged in
      And a form template exists

    Scenario: Admin sees all rule type options
      When the admin opens the notification recipients section
      Then they should see rule types "Fixed email", "Project role", and "Named alias"
```

Full syntax rules: [gherkin-primer.md](references/gherkin-primer.md).

---

## Integration hooks

### spec.md

Keep `WHEN/THEN/SHALL` and requirement IDs. Add a **Gherkin** pointer per story when scenarios exist.

### tasks.md — Done when

```markdown
**Done when**:
- [ ] Scenario `@NOTIF-01` "Admin sees all rule type options" — Manual UAT PASS
- [ ] Scenario `@NOTIF-01` "Admin saves and reloads a rule" — Gate: `cd api && npm test`
```

### validate.md — Scenario validation

For each tagged scenario, present steps and expected outcomes; record PASS/FAIL mapped to requirement ID.

```markdown
### Scenario: Admin sees all rule type options (@NOTIF-01)

| Step | Expected | Result |
| --- | --- | --- |
| Given a form admin is logged in | Admin session active | PASS |
| When the admin opens the notification recipients section | Section visible | PASS |
| Then they should see rule types ... | Three options shown | PASS |
```

Phase handoff details: [spec-driven-integration.md](references/spec-driven-integration.md).

---

## Skill integrations

This skill is invoked **by** [spec-driven](../spec-driven/SKILL.md) during Specify, Tasks, and Validate. Do not re-run the full spec-driven pipeline from here.

When proof requires automated tests, read [.specs/codebase/TESTING.md](../../../.specs/codebase/TESTING.md) for gate commands — do not invent test commands.

**Out of scope for this skill:**

- Cucumber runner setup or step definition source files
- Replacing `WHEN/THEN/SHALL` lines in `spec.md`
- Implementing features (hand off to spec-driven Execute)

---

## Quick checklist

Before finishing:

- [ ] Every scenario maps to at least one requirement ID
- [ ] Every scenario has a proof method in the mapping table
- [ ] Steps use domain language (see [anti-patterns.md](references/anti-patterns.md))
- [ ] 3–5 steps per scenario (Background excluded from count)
- [ ] `spec.md` still contains original `WHEN/THEN/SHALL` criteria
- [ ] No external URLs in generated `.feature` files or skill outputs
