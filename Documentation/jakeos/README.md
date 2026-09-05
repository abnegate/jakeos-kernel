# JakeOS kernel

This tree is a fork of the Linux kernel. It keeps Linux's hardware support and
mechanisms and adds the native JakeOS model behind the native ABI: Components,
Tasks and TaskGroups, Capabilities, Channels, Operations, MemoryObjects and
ResourceDomains. Native software never sees POSIX; Linux software keeps the
Linux ABI through the Linux personality.

The project roadmap, decisions and conventions live in
https://github.com/abnegate/jakeos. Every change to this tree that completes a
roadmap task carries a `Roadmap: <TASK-ID>` trailer.

## Repository

| Remote | URL | Role |
|---|---|---|
| origin | https://github.com/abnegate/jakeos-kernel | the fork; `main` is the integration branch |
| upstream | https://github.com/torvalds/linux | mainline Linux; release tags are merged into `main` |

The fork is cut from the upstream release tag named in `.jakeos/toolchain.toml`
(`upstream.tag`). Release candidates are never bases and never merged; only
release tags (`vX.Y`) and their stable point releases (`vX.Y.Z`) are.

## Branch and tag policy

- `main`: the fork. Only merge commits from upstream tags and reviewed pull
  requests land here. History is never rewritten (roadmap decision D-0168).
- `jakeos-X.Y.N`: fork tags. `X.Y` is the merged upstream release, `N` is the
  fork revision on that base. A tag, once pushed, is never moved or deleted.
- `series/<name>`: an upstream-candidate patch series kept rebased for
  submission (see below). These branches may be rewritten; nothing pins them.

## Toolchain

`.jakeos/toolchain.toml` pins rustc, LLVM and bindgen. Clang is the only C
compiler (D-0036); `make LLVM=1` is the only supported invocation. The pinned
rustc is at least upstream's minimum for the merged tag and within two releases
of current stable (D-0165). Raising the pin is a pull request that changes the
file and nothing else, and it accompanies any upstream merge that requires it.

## Licence

All code in this tree, inherited or new, is GPL-2.0-only (D-0162). Layer 1 ABI
headers carry the Linux syscall-note exception (D-0008 in the roadmap, task ABI-029)
so that native programs including them are not derivative works. Code intended
for reuse above the ABI is authored in the platform repository under MIT and
vendored here under an entry in `Documentation/jakeos/vendored.md`.

## Workflows

- `Documentation/jakeos/upstream-merge.md`: merging an upstream release tag.
- `Documentation/jakeos/series.md`: maintaining an upstream-candidate series and
  rebasing it for submission without touching `main`.
- `Documentation/jakeos/divergence.md`: the divergence ledger every fork patch
  is classified in.
