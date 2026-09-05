# Divergence ledger

Every fork commit that is not an upstream merge is classified here. The CI gate
(roadmap KRN-008) fails when a commit on `main` has no ledger classification.

Classes: `upstream-candidate` (will be submitted to Linux, see `series.md`),
`fork-only` (native model code that cannot go upstream), `temporary` (a
workaround with a named removal condition).

## Budget

The divergence budget per upstream merge is recorded here once the first merge
has produced a baseline: conflicted files, resolution time and the count of
fork-only lines touched by the merge.

## Merges

| Upstream tag | Fork tag | Conflicted files | Notes |
|---|---|---|---|
| v7.2 | jakeos-7.2.0 | none (base) | fork cut from this tag |

## Patches

| Commit | Class | Series or removal condition | Roadmap task |
|---|---|---|---|
| (bootstrap) | fork-only | none | KRN-010 |
| workflow: upload-artifact v7 | fork-only | none | KRN-010 |
