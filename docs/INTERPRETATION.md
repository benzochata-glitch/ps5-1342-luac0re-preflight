# Result interpretation

## Evidence classes

**DIRECT** — a real retail PS5 on exact FW 13.42 produced the reported output.

**DERIVED** — logically computed from DIRECT evidence without adding an untested
platform assumption.

**INFERRED** — plausible from source/nearby-firmware similarity but not directly
measured on exact FW 13.42.

**HYPOTHESIS** — a testable proposition.

**UNKNOWN** — no adequate evidence yet.

## What a PASS changes

`E40_VERDICT=PASS` changes only the native-userland/JIT compatibility gate for
that tested console/session.

It is evidence for:
- exact FW 13.42 Luac0re JIT/native-userland execution
- benign syscall transport
- errno calibration through `close(-1)`

It is not evidence for:
- kernel compromise
- arbitrary kernel read/write
- AIO exploitability
- hypervisor compromise
- Linux bootability

## Reproducibility target

A stronger public checkpoint should require:
- at least 3 independent exact-13.42 consoles
- complete text logs
- at least 2 PS5 model families when possible
- no modified firmware check
- no concurrent kernel exploit payload

This is a research threshold, not statistical proof.
