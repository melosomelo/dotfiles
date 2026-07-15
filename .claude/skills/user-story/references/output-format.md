# Required output format

Use exactly this structure per story. Do not add extra sections. Do not include
explanations outside the format.

## File layout

| Case | Top-level structure |
| --- | --- |
| **Single story** | `# [Feature name]` at file top + **Context** below |
| **Multiple stories** | File-level **Overview** table + `### US-NN: [Title]` per story + **Context** under each header |

### Overview table (multiple stories)

Place after the file title / metadata links, before the first `### US-NN:`:

```markdown
| Story | Title | Priority | Requirements |
| --- | --- | --- | --- |
| US-01 | [Short title] | High | [FEAT]-01, [FEAT]-02 |
| US-02 | [Short title] | High | [FEAT]-03 |
```

Must align with the index table written back to `spec.md` ([spec-writeback.md](spec-writeback.md)).

---

## BDD Scenarios — where Gherkin lives

Use **one canonical location** per story — never duplicate the same scenarios in
both `user-stories.md` and `acceptance/*.feature`.

| Condition | `## BDD Scenarios (Gherkin)` section |
| --- | --- |
| No `acceptance/[story-slug].feature` for this US | **Required** — embed the Gherkin block (see template below) |
| `acceptance/[story-slug].feature` exists (via [gherkin-acceptance](../../gherkin-acceptance/SKILL.md)) | **Pointer only** — link to the `.feature` file; do **not** embed Gherkin |

When using a pointer, keep **Acceptance Criteria** bullets complete — they remain
the human-readable contract; the `.feature` file is the executable proof layer.

---

## Template — markdown sections

```markdown
# [Short and descriptive feature name]
<!-- omit # title when file contains multiple US-NN sections -->

**Context:** [1 to 2 sentences explaining the business problem this feature solves]

---

## User Story

**As** a [primary actor],
**I want** [action or capability],
**so that** [business objective — the real benefit].

**Priority:** High | Medium | Low
<!-- from spec; when absent, note in Open Questions -->

---

## Acceptance Criteria

List each criterion in Given/When/Then format.
Mandatory coverage: happy path, main errors, and at least one edge case.

- **Given** [precondition or initial state],
  **when** [user action or event],
  **then** [expected and measurable result].

---

## BDD Scenarios (Gherkin)

<!-- Mode A (no .feature file): embed the Gherkin block from "Template — Gherkin block" below -->
<!-- Mode B (.feature exists): pointer only — example:

**Gherkin**: [acceptance/configure-recipients-by-project-role.feature](./acceptance/configure-recipients-by-project-role.feature)
See [acceptance/MAPPING.md](./acceptance/MAPPING.md) for proof methods when present.

-->

---

## Out of Scope

This story does not cover:
- [item explicitly out of scope]
- [item that could be confused but will not be implemented here]

If nothing is excluded, write one sentence confirming full scope. Never leave blank.

---

## Test Coverage Suggestions for the Test Agent

Scenarios the test creation agent should prioritize when generating scripts:
- [ ] [priority test scenario 1]
- [ ] [priority test scenario 2]
- [ ] [priority test scenario 3]

---

## Open Questions

Decisions that need to be made before implementation:
1. [direct question about ambiguity detected in step 3]
2. [question about unspecified business rule]

Omit only when genuinely empty.
```

---

## Template — Gherkin block (Mode A only — under `## BDD Scenarios`)

Use this block **only** when no standalone `.feature` file exists for the story.
When `acceptance/*.feature` is canonical, use the pointer format in the template
above instead.

```gherkin
Feature: [feature name — same as the title above]

  Background:
    Given [precondition common to all scenarios, if any]

  Scenario: [main scenario name — happy path]
    Given [initial state]
    And [additional condition, if needed]
    When [user action]
    Then [expected result]
    And [additional result, if needed]

  Scenario: [most critical error scenario name]
    Given [initial state]
    When [invalid action or failure condition]
    Then [expected message or behavior]

  Scenario: [relevant edge case]
    Given [boundary condition]
    When [action]
    Then [expected result at the boundary]

  Scenario Outline: [name — 3+ data variations only]
    Given [context with <variable>]
    When [action with <variable>]
    Then [expected result <result>]

    Examples:
      | variable | result    |
      | value1   | expected1 |
      | value2   | expected2 |
```

---

## Section rules

| Section | Rule |
| --- | --- |
| Acceptance Criteria | Bullet Given/When/Then — always required; separate from Gherkin |
| BDD Scenarios | **Mode A:** embedded executable Gherkin. **Mode B:** pointer to `acceptance/*.feature` only — see [quality-rules.md](quality-rules.md) |
| Out of Scope | Mandatory — never blank |
| Test Coverage Suggestions | Checkbox list for the test-creation agent |
| Open Questions | Every unresolved item from reasoning step 3 |
