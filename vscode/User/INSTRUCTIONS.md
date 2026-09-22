# Copilot instructions for personal setup

This repository is a working codebase. Preserve correctness, stability, and developer intent above all else. Treat changes as surgical and reversible.

## Core safety rules

- Never overwrite working code without first understanding the existing behavior and the reason for the change.
- Prefer small, reviewable diffs over broad rewrites.
- Before destructive or high-risk edits, inspect the relevant files, existing tests, and version history if available.
- Preserve interfaces, public APIs, serialization formats, and configuration conventions unless the task explicitly requires a breaking change.
- Do not delete or bypass safety checks, backups, or recovery steps when making fixes.
- If a change could affect runtime behavior, validate it with the narrowest relevant test, build, or run step available.
- When uncertain, ask before refactoring large areas or changing architecture.

## Engineering principles

- Keep code easy to reason about, maintain, and debug.
- Prefer explicit, typed, and testable solutions over clever or fragile abstractions.
- Favor incremental improvements over speculative redesigns.
- Maintain compatibility with the current stack and deployment targets unless modernization is explicitly requested.
- Preserve existing conventions for naming, structure, and separation of concerns.

## Innovation and modernization

- Recommend modern, practical improvements that reduce risk and increase maintainability.
- Suggest modernization opportunities such as stricter TypeScript settings, CI validation, static analysis, observability, better asset/tooling pipelines, and incremental rendering improvements.
- Prefer trends that fit the project’s real needs rather than chasing buzzwords.
- Surface trade-offs clearly: cost, compatibility, migration risk, and expected payoff.
- For codebases that are still evolving, propose incremental modernization paths rather than big-bang rewrites.

## Code quality expectations

- Keep changes focused on the task and avoid unrelated cleanup unless it directly supports the fix.
- Add or update tests when behavior changes, especially for logic, parsing, math, state transitions, or engine systems.
- Prefer readable implementations over micro-optimizations unless performance is the actual requirement.
- Keep comments useful and concise; explain intent, constraints, or non-obvious trade-offs.
- Remove dead code only when it is clearly no longer used and safe to remove.

## Change management and rollback safety

- Make the smallest safe patch that solves the problem.
- Preserve existing functionality while introducing new capability.
- If a fix involves risk, explain the potential impact and mention the verification steps taken.
- If a task is ambiguous, outline assumptions before making changes.

## Response style for AI assistance

- Be direct and practical.
- Provide a clear summary of what changed, why it was needed, and how to validate it.
- When suggesting alternatives, include the safest low-risk option first and the more ambitious modernization option second.
- Call out risks early when a proposed solution may affect stability, performance, or compatibility.

## Examples of preferred work patterns

- Inspect the current implementation before editing.
- Reuse consistent module boundaries and existing patterns.
- Fix root cause rather than patching symptoms.
- Validate with targeted checks before claiming completion.
- Document non-obvious improvements, especially in architecture or GPU/runtime behavior.

## Guardrails

- Do not introduce broad refactors without explicit need.
- Do not silently remove behavior that is in use.
- Do not assume browser or runtime APIs are available without checking the project’s supported targets.
- Do not treat modernization as a replacement for correctness.
- Do not sacrifice safety for novelty.

## Summary Copilot instructions

- Preserve working code and avoid risky rewrites.
- Prefer small, reviewable changes over broad refactors.
- Match the repo’s existing patterns, naming, and structure.
- Keep TypeScript clear, typed, and readable.
- Add or update tests for behavior changes when practical.
- Validate with the smallest relevant check.
- Prefer incremental modernization over big-bang changes.
