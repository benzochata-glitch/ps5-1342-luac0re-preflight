# PS5 13.42 Luac0re Preflight

A small, fail-closed compatibility probe for **retail PS5 system software 13.42**
running through the public Luac0re JIT/native-userland path.

This repository is **not a jailbreak**, **not a kernel exploit**, and **not a
hypervisor exploit**. Its only goal is to answer one narrow question:

> Can the public Luac0re native-userland/JIT path execute a benign syscall and
> errno calibration test on an exact FW 13.42 console?

## What the probe does

The probe requires all of the following before it can report `PASS`:

1. `PLATFORM == "PS5"`
2. `FW_VERSION == "13.42"`
3. Luac0re exposes the expected JIT syscall/errno primitives
4. `getpid()` returns a valid PID
5. `close(-1)` returns `-1`
6. process-local `errno` becomes `EBADF (9)`

Successful output ends with:

```text
E40_VERDICT=PASS
```

Other terminal states are `DENY` and `INCONCLUSIVE`. Neither advances any
kernel or hypervisor claim.

## Safety boundary

This release intentionally contains **no** AIO, `aio_multi_wait`, UAF/race,
heap spray/reclaim, kernel read/write primitive, IOMMU/TMR/VMCB modification,
hypervisor modification, persistence mechanism, or internal-storage
modification.

The only write performed by the probe is clearing the current process's own
`errno` slot before calling `close(-1)`.

## Testing

Read [docs/TESTING.md](docs/TESTING.md) first.

Please use only an existing Luac0re setup that you already trust. Do not enable
or run Poopsploit, P2JB, Bagagwa, AIO/UAF, kernel payloads, or unrelated
jailbreak chains as part of this test.

## Reporting results

Open a **13.42 Test Result** issue using the supplied template.

Useful data:
- exact firmware string
- PS5 model family (CFI-10xx / CFI-11xx / CFI-12xx / Slim)
- Luac0re version/commit if known
- complete `E40_*` text output
- whether the application exited/crashed/restarted

Do **not** post console serial numbers, PSN account details, IP addresses,
savedata, authentication tokens, or personally identifying information.

## Evidence policy

One `PASS` proves only that one exact-13.42 console/session produced the
expected benign userland result. It does **not** prove a kernel exploit, K42,
IOMMU/VMCB control, hypervisor transition, or Linux boot support.

See [docs/INTERPRETATION.md](docs/INTERPRETATION.md).

## Upstream references

- Luac0re: https://github.com/Gezine/Luac0re
- LuaPSX: https://github.com/soniciso1/LuaPSX

This is an independent compatibility probe, not an official Luac0re release.

## Release

Current package: **v0.2.0**
