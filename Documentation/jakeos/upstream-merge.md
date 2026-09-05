# Merging an upstream release

Policy: decision D-0166 (base is the newest mainline release tag) and D-0168
(each release tag is merged, history is never rewritten).

## When

- A new mainline release tag `vX.Y` appears: merge it within the divergence
  budget recorded in `divergence.md`.
- A stable point release `vX.Y.Z` for the currently merged series appears: merge
  it in the next integration window.
- Release candidates (`vX.Y-rcN`) are never merged.

## Steps

```sh
git fetch upstream --tags
git switch main
git merge --no-ff --log vX.Y            # or vX.Y.Z
# resolve conflicts; every conflicted file is listed in the ledger entry
make LLVM=1 defconfig && make LLVM=1 -j"$(nproc)"
scripts/jakeos/ledger-entry.sh vX.Y      # appends the merge record to divergence.md
git commit --amend                       # only to include the ledger entry in the merge commit
git tag jakeos-X.Y.0
git push origin main jakeos-X.Y.0
```

If the merged tag raises the Rust or LLVM minimum above the pin in
`.jakeos/toolchain.toml`, the pin change is part of the same pull request.

## Conflicts

Fork-only code lives under `jakeos/`, `rust/jakeos/`, `include/jakeos/` and
`Documentation/jakeos/`, and hooks into shared files through named functions so
that conflicts stay small. A conflict in a shared file is recorded in the ledger
entry with the resolution. Two consecutive merges over the divergence budget
trigger a review of D-0166.
