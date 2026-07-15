# Anti-patterns

Avoid these when drafting or reviewing user stories.

| Anti-pattern | Problem | Fix |
| --- | --- | --- |
| **Vague acceptance criteria** | "user sees results", "system responds correctly" | State exact message, value, or observable outcome |
| **Compound stories** | Two goals stitched with "and" | Split into separate `US-NN` entries |
| **Implementation leakage** | Class names, SQL, DB columns in AC/Gherkin | Rewrite in business/domain language |
| **Multiple When steps** | One scenario with several user actions | One `When` per scenario; split or use `And` |
| **Unnecessary Background** | Shared setup only some scenarios need | Move preconditions into individual scenarios |
| **Premature Scenario Outline** | Outline with fewer than 3 data variations | Use separate scenarios instead |
| **Silent assumptions** | Defaults or rules not stated by user or spec | Move to Open Questions |
| **Empty Out of Scope** | Section omitted or blank | List exclusions or confirm full scope in one sentence |
| **Missing test suggestions** | No Test Coverage Suggestions section | Add prioritized checkbox list for test agent |
| **Reasoning in output** | Internal steps 1–5 written into the artefact | Keep reasoning internal; output only the template |
| **Duplicate Gherkin** | Same scenarios in `user-stories.md` and `acceptance/*.feature` | Pick one canonical location — pointer in US when `.feature` exists |
| **Editing forbidden spec sections** | Changing Requirements, traceability, or other `spec.md` topics from this skill | **Only** `## User Stories` — see [spec-writeback.md](spec-writeback.md) |
| **Technical language in body** | API endpoints, framework terms in user-facing sections | Use business language per [quality-rules.md](quality-rules.md) |
