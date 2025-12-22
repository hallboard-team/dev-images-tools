# Project Notes (Humans + Agents)

Use this file to capture repo-specific conventions for both humans and coding agents.

## Image Tagging
- Tag format should reflect the configured versions: `dotnet<major.minor>-node<major>-ng<major>`.
- Keep tag generation logic aligned with `.github/workflows/build-node-angular.yml`.
- If you change versioning in the workflow, check any scripts or docs that reference tags.
- For production later, prefer publishing both:
  - a pinned tag (exact versions) for reproducibility
  - a moving tag (major-only) for convenience

## Workflow Changes
- Changes to build/tag behavior should be kept in the GitHub Actions workflow.
- Avoid adding network-dependent steps unless explicitly requested.

## Scope
- These images are intended for dev use now; any production hardening should be documented here as it is added.
