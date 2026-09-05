# Upstream-candidate series

Policy: decision D-0167 (upstream-first for drivers and generic Rust
abstractions). `main` is never rebased. Patches meant for upstream Linux are
carried as a series branch that is rebased for submission only.

## Layout

- `series/<name>` branches from the merged upstream tag and contains only the
  patches of that series, each tagged in the ledger as `upstream-candidate`.
- The same commits land on `main` through an ordinary merge of the series branch.
- When upstream accepts the series, the next upstream merge brings the
  accepted form into `main`; the fork's copies are dropped by that merge and the
  ledger entries are closed.

## Rebase for submission

```sh
git fetch upstream --tags
git switch series/<name>
git rebase --onto vX.Y "$(git merge-base series/<name> main)"
git range-diff main...series/<name>@{1} main...series/<name>
git format-patch --cover-letter -o out/ vX.Y..series/<name>
```

`main` and every `jakeos-*` tag are untouched by this workflow; only the series
branch is rewritten.

## Exercising the workflow

The bootstrap of this repository exercised the rebase on the empty range
`v7.2..main` (no fork commits yet): `git rebase --onto v7.2 v7.2` on a scratch
branch reported nothing to do, `git range-diff v7.2..main v7.2..main` was
empty, and `git tag --points-at v7.2` still resolved to the upstream tag.
