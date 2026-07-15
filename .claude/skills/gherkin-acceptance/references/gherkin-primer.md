# Gherkin primer

Condensed rules for writing `.feature` files in this project. English keywords only (`# language: en` is optional; default is English).

---

## Document structure

```
Feature: [high-level capability]
  [optional free-form description — not executed]

  Rule: [one business rule]          # optional, Gherkin 6+
    Background:                     # optional, runs before each scenario in scope
      Given ...
    Scenario: [concrete example]
      Given ...
      When ...
      Then ...

  Scenario Outline: [template name]
    Given ...
    When ...
    Then ...
    Examples:
      | col1 | col2 |
      | val  | val  |
```

- One `Feature:` per `.feature` file.
- `Scenario` and `Example` are synonyms — prefer `Scenario` in this repo.
- Comments start with `#` at the beginning of a line.

---

## Step keywords

| Keyword | Role | Guidance |
| --- | --- | --- |
| **Given** | Initial context — system in a known state | Past tense setup: data exists, user is logged in, API is configured. Avoid user actions here. |
| **When** | Event or action | Something happens: user submits, API is called, timeout occurs. Use domain language, not implementation. |
| **Then** | Expected observable outcome | What the user or external system sees: message, email, HTTP status, UI text. Must be verifiable without reading the database. |
| **And** / **But** | Continuation of previous keyword | Use for readability after the first Given/When/Then in a block. |
| **\*** | Bullet-style list | Alternative to repeated `And` for list-like preconditions. |

Cucumber matches step text **without** the keyword — do not duplicate the same step text under different keywords.

---

## Length and structure

- **3–5 steps** per scenario (excluding Background). Split long flows into multiple scenarios.
- **Background**: shared `Given` steps run before each scenario in the Feature or Rule. Keep to **≤4 lines**; move detail into higher-level steps.
- **Scenario Outline**: same flow, different data — use for role variants, error codes, boundary values.
- **Rule**: groups scenarios that illustrate one business rule (e.g. "There can be only one project leader notification").

---

## Tags

Place `@tag` above `Feature:`, `Rule:`, or `Scenario:`.

| Tag pattern | Purpose |
| --- | --- |
| `@P1`, `@P2`, `@P3` | User story priority from `spec.md` |
| `@NOTIF-01`, `@AUTH-03` | Requirement ID traceability |
| `@edge` | Edge case from spec Edge Cases section |

Multiple tags on one line: `@P1 @NOTIF-01 @NOTIF-02`.

---

## Step arguments

**Doc strings** — multiline text passed to a step:

```gherkin
Given a form template with notification body
  """
  Line one
  Line two
  """
```

**Data tables** — structured rows:

```gherkin
Given the following notification aliases exist:
  | alias | email           |
  | KAM   | kam@example.com |
  | HR    | hr@example.com  |
```

Use tables in scenarios sparingly; prefer `Scenario Outline` + `Examples` for parameterized tests.

---

## Step organization (when step definitions exist later)

- Group step definitions by **domain concept** (authentication, forms, notifications), not by `.feature` file name.
- Prefer parameterized steps: `Given a form template with rule type "<type>"` over three nearly identical steps.
- Do not write step definitions for steps that appear in no scenario.
- Refactor shared logic into helper methods inside step definition modules — keep `.feature` files at business language.

This project does **not** require Cucumber step definitions today. `.feature` files are living specifications and UAT scripts until a BDD runner is adopted.

---

## Language and tone

- Write for **domain experts** and **testers**, not for Angular/NestJS internals.
- Name actors clearly: `form admin`, `tenant admin`, `project leader` — not `User A`.
- Quote user-visible strings: `"Notification Recipients"`, `"Fixed email"`.
- Avoid: CSS selectors, DOM ids, SQL, table/column names in `Then` steps.

---

## Minimal valid example

```gherkin
@P1 @NOTIF-01
Feature: Configure smart notification recipients

  Rule: Admin can define recipient rule types

    Background:
      Given a form admin is logged in
      And a form template exists

    Scenario: Admin sees all rule type options
      When the admin opens the notification recipients section
      Then they should see rule types "Fixed email", "Project role", and "Named alias"

    Scenario Outline: Admin saves and reloads a rule
      Given the admin selects rule type "<type>"
      And sets value "<value>"
      When they save the form template
      And reopen the notification recipients section
      Then the rule type should be "<type>"
      And the value should be "<value>"

      Examples:
        | type         | value             |
        | Fixed email  | ops@example.com   |
        | Project role | project_leader    |
        | Named alias  | KAM               |
```
