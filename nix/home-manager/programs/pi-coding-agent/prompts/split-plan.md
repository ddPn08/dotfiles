---
description: Plan a large feature, refactor, or migration as minimal staged PRs starting from the smallest working slice
argument-hint: "<goal and constraints>"
---
Investigate the repository (read-only—do NOT edit files) and propose a staged PR plan for:

$ARGUMENTS

Follow these principles:
1. **Clarify goal, hard constraints, and acceptable trade-offs**: Identify what must not break vs. what temporary breakage or non-goals are acceptable so we avoid complex migration/compatibility layers (like unnecessary Blue/Green or dual paths).
2. **Reuse existing repo mechanisms and official upstream tooling**: Inspect current manifests, infra/CI patterns, and neighboring modules. Explicitly call out what existing patterns/official artifacts to reuse and what new tools/ways NOT to introduce in this work.
3. **Split into minimal, reviewable staged PRs**:
   - Separate obsolete-code/resource deletion, repo-wide tooling/policy changes, and production deploy/CI from core functional steps.
   - Prove the smallest standalone vertical slice first (e.g. minimal config/manual CLI verification with concrete reproduction commands, then one real workload/case end-to-end, then integration with the main system, then expansion to remaining cases).
   - Keep each PR focused on a single layer/concern with explicit scope, non-goals, and minimal verification command.
4. **Surface structural trade-offs early**: If a quick local fix competes with a cleaner structural refactor, present Option 1 (minimal local change) and Option 2 (staged structural refactor) concisely so the user can decide before coding.

Wait for the user's approval before implementing.
