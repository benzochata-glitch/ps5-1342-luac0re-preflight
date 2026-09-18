# Suggested r/ps5homebrew post

**Title:**
PS5 FW 13.42 testers wanted — benign Luac0re JIT/userland compatibility probe

**Body:**

I'm collecting independent runtime evidence for PS5 firmware 13.42.

This is **not a jailbreak or kernel exploit**. The test is deliberately limited
to the Luac0re native-userland/JIT path and performs only:

`getpid()` and `close(-1) -> errno EBADF (9)`.

There is no AIO, UAF/race, heap spray, kernel write, IOMMU/VMCB/HV modification
or persistence code in the release.

I'm specifically looking for people who already have a trusted Luac0re setup
and an exact FW 13.42 console.

Please report:
- model family only (CFI-10xx/11xx/12xx etc.)
- exact firmware
- Luac0re version/commit if known
- full `E40_*` text output

Please do **not** post your serial number, PSN information, IP address or savedata.

A PASS establishes only exact-13.42 userland/JIT compatibility — it does not
prove a kernel or hypervisor exploit.

GitHub: <REPOSITORY_URL>
Release: <RELEASE_URL>
