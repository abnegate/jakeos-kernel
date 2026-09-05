#!/usr/bin/env bash
# Appends an upstream merge record to Documentation/jakeos/divergence.md.
# Usage: scripts/jakeos/ledger-entry.sh <upstream-tag> [fork-tag]
set -euo pipefail
tag="${1:?upstream tag}"
fork="${2:-jakeos-${tag#v}.0}"
ledger="Documentation/jakeos/divergence.md"
conflicts="$(git diff --name-only --diff-filter=U | tr '\n' ' ')"
[ -n "$conflicts" ] || conflicts="none"
printf '| %s | %s | %s | merged |\n' "$tag" "$fork" "$conflicts" >> "$ledger"
git add "$ledger"
