---
description: Review current changes for simplicity, scope discipline, over-defensiveness, and security boundaries before opening a PR
argument-hint: "[base-ref or focus]"
---
Perform a read-only self-review of the current changes. Do NOT modify any files.

1. Inspect the diff:
   - If `$1` looks like a git ref/range (e.g. `<base>...HEAD`, `HEAD~1`), inspect `git diff $1` and `git status --short`.
   - Otherwise, do NOT assume the repository's default branch (`origin/master` / `origin/main`) is the base—the current branch may be stacked on another branch:
     - Check `git status --short`. If there are uncommitted changes, inspect `git diff` and `git diff --cached` (if the branch also has commits and it is unclear whether to review only uncommitted changes or the whole branch, ask).
     - When reviewing branch commits, determine the actual parent/base branch first—e.g. from an open PR's `baseRefName` (`gh pr view --json baseRefName` if available) or from the closest ancestor branch in git history (`git log --decorate --oneline` / merge-bases against other branches).
     - If the base ref cannot be determined unambiguously, ask the user which base branch/ref to diff against instead of falling back to `origin/master` or `origin/main`.
   - If extra focus was given (`$ARGUMENTS`), pay special attention to it.

2. Check the diff against these criteria (referencing the repository's own `AGENTS.md` and existing patterns first):
   - **Simplicity & Upstream/Existing Alignment**: Is this the simplest solution under the real constraints? Are there custom patches, custom build/deploy scripts, new tools/dependencies, or duplicate sources of truth where official upstream artifacts or an existing repository pattern would work directly?
   - **Scope & PR Split**: Are unrelated file moves, config/`AGENTS.md` edits, or repo-wide tooling/policy changes mixed in? Does the diff combine multiple layers or concerns (e.g. infra + app, cleanup + migration) that should be split into smaller staged PRs?
   - **Structure & Cohesion**: Does a local patch add complex state/effects/workarounds where simplifying the underlying data structure or moving logic to the owning domain module would be cleaner? Are layers split only for testing?
   - **Over-defensiveness & Noise**: Are there duplicate validations already handled downstream/by parsers/by types/at runtime, unnecessary pre-flight checks in local scripts, speculative config branches or migration compat layers, self-evident comments, unrequested docs, or AI-like undefined jargon?
   - **Test Discipline**: Were tests added in areas without an existing test culture, or for thin delegation/internal wrappers instead of existing boundaries?
   - **Security & Privilege Boundaries**: Are IAM/cloud roles least-privilege, data access scoped (e.g. per-object presigned URLs rather than broad mounts), and secrets excluded from CLI arguments and logs?

3. State the exact diff range reviewed, then report findings concisely with file paths and line numbers, grouped into:
   - **Must fix / Rethink** (blocking design, scope, or privilege issues)
   - **Simplify / Trim** (unnecessary complexity, checks, comments, or tests)
   - **PR Split Suggestion** (only if the diff should be broken up)
   If no real issues exist, say so briefly—do not invent nitpicks.
