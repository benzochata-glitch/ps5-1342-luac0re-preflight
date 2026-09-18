# Testing guide

## Scope

This test is for a PS5 that already has a working, trusted Luac0re userland/JIT
environment. The test itself does not install Luac0re and contains no kernel or
hypervisor exploit.

## Before testing

Confirm:
- the console reports system software `13.42`
- automatic system updates are disabled if preserving that firmware matters
- you are using an existing Luac0re setup
- you are not launching a kernel-exploit payload as part of this test

Do not share console serial numbers or account credentials.

## Probe

Use:

`probe/e40_preflight_1342.lua`

Run it through the normal remote-Lua execution mechanism of your existing
Luac0re setup.

Do not modify the firmware check before reporting a result.

## Expected terminal outputs

### PASS

```text
E40_FW=13.42
E40_PID=<positive number>
E40_CLOSE_RET=-1
E40_ERRNO=9
E40_VERDICT=PASS
```

### DENY

Preserve the full `E40_REASON=...` line.

### INCONCLUSIVE

The probe executed but `close(-1)` / errno behavior did not match the expected
calibration result.

## Stop condition

Stop after this probe.

Do not continue into AIO, UAF, race, kernel-write, IOMMU, VMCB or hypervisor
experiments merely because this probe reports `PASS`.

## Report

Use the repository's **13.42 Test Result** issue template and paste the complete
`E40_*` output as text.
