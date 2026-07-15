# spec-driven integration

How this skill fits the [spec-driven](../../spec-driven/SKILL.md) pipeline without replacing it.

---

## Layer model

| Layer | Location | Role |
| --- | --- | --- |
| **Contract** | `.specs/features/[feature]/spec.md` | Requirement IDs, user stories, `WHEN/THEN/SHALL` — source of truth for traceability |
| **Proof** | `.specs/features/[feature]/acceptance/*.feature` | Gherkin scenarios with Given/When/Then and tags |
| **Execution** | `tasks.md`, validation report | Done-when checklists, gate commands, UAT PASS/FAIL |

```
spec.md (WHEN/THEN + Req IDs)
        │  expand with gherkin-acceptance
        ▼
acceptance/*.feature (Given/When/Then + @tags)
        │  derive proof method
        ├──► tasks.md       → Done when + Gate
        └──► validate.md    → UAT roteiro / PASS-FAIL table
```

**Rule:** Every scenario maps to one or more requirement IDs. Never drop `WHEN/THEN/SHALL` from `spec.md` when adding Gherkin.

---

## Phase handoffs

### Specify → gherkin-acceptance

**Trigger:** User story acceptance criteria and requirement traceability table exist in `spec.md`.

**Actions:**

1. Confirm each criterion is testable (observable outcome).
2. Write `.feature` file(s) under `acceptance/`.
3. Add per-story **Gherkin** pointer in `spec.md`.
4. Emit mapping table (see below).

**Skip Gherkin when:** Quick mode with ≤3 files and user did not ask for scenarios.

### Tasks → gherkin-acceptance

**Trigger:** `tasks.md` is being created or updated; tasks reference requirement IDs.

**Actions:**

1. For each task, list scenarios that prove its requirements.
2. Add `Done when` bullets referencing scenario title + `@REQ-ID` + proof method.
3. Set `Gate:` from `.specs/codebase/TESTING.md` when proof is automated.

Example:

```markdown
### T11: Notification recipients UI

**Requirement**: NOTIF-01

**Done when**:
- [ ] Scenario `@NOTIF-01` "Admin sees all rule type options" — Manual UAT PASS
- [ ] Scenario `@NOTIF-01` "Admin saves and reloads a rule" — Manual UAT PASS
- [ ] Gate check passes: `cd web && npm run lint`
```

### Validate → gherkin-acceptance

**Trigger:** Feature-level validation, UAT, or "walk me through it".

**Actions:**

1. Load scenarios for the priority being validated (P1 first).
2. Present one scenario at a time with steps and expected outcomes.
3. Record PASS/FAIL per step or per scenario; map failures to requirement IDs.
4. Update requirement status in `spec.md` traceability table per [validate.md](../../spec-driven/references/validate.md).

**Validation report section** (add when Gherkin exists):

```markdown
## Gherkin scenario validation

### P1: Configure role-based recipient rules

| Scenario | Req ID | Result | Notes |
| --- | --- | --- | --- |
| Admin sees all rule type options | NOTIF-01 | PASS | — |
| Admin saves and reloads a rule | NOTIF-01 | FAIL | Alias dropdown empty on reload |
```

---

## Mapping table template

Emit after writing or updating `.feature` files:

| Req ID | WHEN/THEN (spec) | Scenario title | Proof method |
| --- | --- | --- | --- |
| `NOTIF-01` | WHEN admin opens notification recipients… | Admin sees all rule type options | Manual UAT |
| `NOTIF-01` | WHEN saving the template… | Admin saves and reloads a rule | Manual UAT |
| `NOTIF-02` | WHEN form response submitted with project_role rule… | System resolves email via 4PS | Gate: `cd api && npm test` |
| `NOTIF-02` | WHEN 4PS API unavailable… | Notification continues with fixed recipients | Gate + Manual UAT |

Proof method values: `Manual UAT`, `Gate: [command]`, `E2E: [path]`, `Inspection`.

---

## Requirement traceability

Align Gherkin tags with the **Requirement Traceability** table in `spec.md`:

| Requirement ID | Story | Phase | Status |
| --- | --- | --- | --- |
| NOTIF-01 | P1: Configure role-based rules | Design | Pending |

When scenarios are written, status may move to **In Tasks** or **Implementing**. After validation PASS, update to **Verified** in the validation report and `spec.md`.

---

## Quick mode

Path: `.specs/quick/NNN-slug/TASK.md`

Optional inline block — no separate `.feature` file unless scope grows:

```gherkin
@quick
Scenario: Seed includes marco user
  Given the database has been reset with seeds
  When an admin queries users by email "marco@example.com"
  Then the user should exist with role "admin"
```

Proof: single **Independent Test** line in `TASK.md` + gate command from `TESTING.md`.

---

## What this skill does not change

- [specify.md](../../spec-driven/references/specify.md) — `WHEN/THEN/SHALL` format stays canonical
- [tasks.md](../../spec-driven/references/tasks.md) — task template structure unchanged; only enriched `Done when`
- [validate.md](../../spec-driven/references/validate.md) — validation process unchanged; optional Gherkin section added
