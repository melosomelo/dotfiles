# Anti-patterns

Common mistakes when writing Gherkin for Sterk features. Each row: avoid → prefer, with a domain example where helpful.

---

## Contract and traceability

| Avoid | Prefer |
| --- | --- |
| Replacing `WHEN/THEN/SHALL` in `spec.md` with only Gherkin | Keep both; add **Gherkin** pointer to `.feature` file |
| Scenarios with no `@REQ-ID` tag | Tag every scenario with the requirement(s) it proves |
| One `.feature` file covering an entire epic | Split by user story or `Rule` (e.g. `p1-configure-recipients.feature`, `p1-resolve-4ps.feature`) |
| Gherkin written before acceptance criteria exist | Write `spec.md` criteria first, then expand |

---

## Step language

| Avoid | Prefer |
| --- | --- |
| `When the admin clicks "#save-btn"` | `When the admin saves the form template` |
| `Then the row exists in notification_rules` | `Then the notification recipients section shows the saved rule` |
| `Given the FormTemplatesService returns mock data` | `Given a form template with a project_leader rule exists` |
| `When POST /api/forms/templates/123 is called` | `When the admin saves the form template` (HTTP detail belongs in step defs or API tests, not feature files) |

**Exception:** API-only features with no UI may use HTTP language in **Then** if that is the observable contract: `Then the response status should be 401`.

---

## Scenario shape

| Avoid | Prefer |
| --- | --- |
| 12-step scenarios mixing setup, action, and many assertions | Background (≤4 lines) + 3–5 step scenario; split assertions across scenarios |
| Repeating the same 6 Given steps in every scenario | `Background:` with high-level steps: `Given a form admin is logged in` |
| Copy-paste scenarios differing only by data | `Scenario Outline` + `Examples` |
| `Given` steps describing clicks or form fills | `When` for user actions; `Given` for established state |

---

## Then steps (observability)

| Avoid | Prefer |
| --- | --- |
| `Then a BullMQ job was enqueued` | `Then a notification email should be sent to "leader@example.com"` |
| `Then Bugsnag.notify was called` | `Then the submission succeeds and fixed recipients still receive email` (observe user-visible outcome; log verification via Gate/Inspection) |
| `Then the JSONB column contains ...` | `Then reloading the template shows the same recipient rules` |

---

## Proof and process

| Avoid | Prefer |
| --- | --- |
| Scenarios with no proof method in mapping table | Always fill **Proof method** column |
| Marking Manual UAT PASS without running steps | Execute or explicitly skip with reason in validation report |
| Inventing `npm test` variants not in TESTING.md | Copy gate commands from `.specs/codebase/TESTING.md` |

---

## Sterk domain examples

### Bad — notification recipients

```gherkin
Scenario: Save rules
  Given I am on /forms/templates/create
  And I click mat-expansion-panel-header
  When I type in input[formcontrolname=email]
  And I click button[type=submit]
  Then notification_rules jsonb equals [{"type":"fixed","email":"a@b.com"}]
```

### Good — notification recipients

```gherkin
@P1 @NOTIF-01
Scenario: Admin saves and reloads a fixed email rule
  Given a form admin editing a form template
  And the admin adds a fixed email rule for "ops@example.com"
  When the admin saves the form template
  And reopens the notification recipients section
  Then the rule type should be "Fixed email"
  And the value should be "ops@example.com"
```

### Bad — 4PS resolution

```gherkin
Scenario: 4PS call
  Given FormNotificationListener is wired
  When form.response.submitted event fires
  Then FourPsClient.getProjectRoleEmail was called with remoteId 999
```

### Good — 4PS resolution

```gherkin
@P1 @NOTIF-02 @edge
Scenario: Notification continues when 4PS is unavailable
  Given a form template with a project_leader rule and a fixed email rule
  And the linked project exists in 4PS
  And the 4PS API is unavailable
  When a form response is submitted on that project
  Then the fixed email recipient should receive a notification
  And no error should be shown to the submitter
```

Proof: Gate with mocked 4PS failure + Manual UAT for submitter experience.

---

## Duplicate step text

These are treated as the **same** step by Cucumber — do not use identical text under different keywords:

```gherkin
Given there is a form template
Then there is a form template
```

Use distinct, outcome-oriented Then text:

```gherkin
Given a form template exists
Then the form template should appear in the template list
```
