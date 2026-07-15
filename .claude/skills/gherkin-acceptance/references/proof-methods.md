# Proof methods

Every Gherkin scenario must declare **how** it will be proven. Record the method in the mapping table and in `tasks.md` / validation output.

Load [.specs/codebase/TESTING.md](../../../.specs/codebase/TESTING.md) before assigning gate or E2E commands. Do not invent commands.

---

## Decision table

| Method | When to use | Where recorded | Typical Sterk command / action |
| --- | --- | --- | --- |
| **Manual UAT** | UI flows, visual checks, human judgment, no automated spec yet | Validation report; `Done when` in `tasks.md` | Walk through scenario steps in browser; user confirms PASS |
| **Gate (unit)** | Service logic, pure functions, NestJS modules with Jest | `tasks.md` → `Gate:` + `Tests:` | `cd api && npm test` |
| **Gate (integration)** | HTTP API, DB-backed flows, supertest E2E in `api/test/` | `tasks.md` → `Gate:` + `Tests:` | `cd api && npm run test:e2e` (if configured) |
| **Gate (web unit)** | Angular components/services | `tasks.md` → `Gate:` | `cd web && npm test` |
| **E2E Playwright** | Critical web user journeys, auth, multi-page flows | `tasks.md` or validation report; reference spec path | `cd web && npm run e2e` — note target spec under `web/e2e/` |
| **Inspection** | Config, env schema, migration applied, seed data | `Done when` checklist only | Verify file/content or CLI output; no user-facing UI |

---

## Choosing a method

```
Is the outcome visible in a browser without code?
  yes → Manual UAT (optionally add Playwright later)
  no → Is there an existing automated test layer for this package?
         yes → Gate (pick unit / integration / e2e from TESTING.md)
         no → Manual UAT or Inspection until tests exist
```

**P1 MVP scenarios:** prefer at least one **Manual UAT** path for user-facing behaviour even when unit tests exist.

**Backend-only features:** Gate (unit/integration) primary; Manual UAT only if no observable API contract (e.g. use supertest assertions mapped to `Then` steps in prose).

---

## Recording in tasks.md

```markdown
**Done when**:
- [ ] Scenario `@NOTIF-02` "System resolves project leader via 4PS" — Gate: `cd api && npm test` (NOTIF-02 resolver spec)
- [ ] Scenario `@NOTIF-01` "Admin sees all rule type options" — Manual UAT PASS
```

```markdown
**Tests**: unit
**Gate**: quick
```

Align `Tests` / `Gate` fields with the spec-driven tasks template and TESTING.md coverage matrix.

---

## Recording in validation (Manual UAT)

Present one scenario at a time (aligns with [validate.md](../../spec-driven/references/validate.md) interactive UAT):

```markdown
### Scenario: Admin sees all rule type options (@NOTIF-01)

**Proof method:** Manual UAT

| Step | Expected |
| --- | --- |
| Given a form admin is logged in | Dashboard loads without error |
| When the admin opens the notification recipients section | Section expands |
| Then they should see rule types "Fixed email", "Project role", and "Named alias" | All three options visible |

**Result:** PASS | FAIL — [notes]
```

---

## Mapping Then steps to automated tests (future)

When Playwright or Jest specs are written, add a comment in the mapping table — not inside the `.feature` file:

| Scenario | Automated counterpart |
| --- | --- |
| Admin sees all rule type options | `web/e2e/form-template-notifications.spec.ts` (planned) |
| System resolves project leader via 4PS | `api/src/.../notification-resolver.service.spec.ts` |

This skill does **not** create step definitions or Cucumber glue code.

---

## Edge cases and non-happy paths

| Spec edge case | Proof method hint |
| --- | --- |
| 4PS timeout (>5 s) | Gate with mocked timeout + Manual UAT for degraded behaviour |
| Duplicate email deduplication | Gate (unit on merge logic) |
| Missing alias in settings | Gate + log inspection (`Inspection`) |
| API 401 on auth | E2E Playwright in unauthenticated project |

Tag edge scenarios with `@edge` and link to the matching `WHEN/THEN` line in spec Edge Cases section.
