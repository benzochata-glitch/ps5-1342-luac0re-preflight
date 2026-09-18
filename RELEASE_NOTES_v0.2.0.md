# v0.2.0 — exact FW 13.42 Luac0re benign preflight

First public tester release.

## Purpose
Collect independent exact-13.42 evidence for Luac0re JIT/native-userland
compatibility.

## Probe
`probe/e40_preflight_1342.lua`

Checks:
- exact PS5 platform
- exact FW 13.42
- JIT syscall availability
- `getpid()`
- process-local errno pointer
- `close(-1) -> EBADF(9)`

## Safety
No AIO, UAF/race, kernel write, IOMMU/TMR/VMCB, hypervisor or persistence code.

## Result reporting
Use the GitHub issue template and include complete `E40_*` text output.
