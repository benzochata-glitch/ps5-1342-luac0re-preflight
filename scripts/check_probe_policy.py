from pathlib import Path

probe = Path(__file__).resolve().parents[1] / "probe" / "e40_preflight_1342.lua"
text = probe.read_text(encoding="utf-8")

required = [
    'PLATFORM ~= "PS5"',
    'tostring(FW_VERSION) ~= "13.42"',
    'jit_syscall.getpid',
    'jit_syscall.close',
    'E40_VERDICT=PASS',
    'errno_val == 9',
]
for token in required:
    if token not in text:
        raise SystemExit(f"FAIL: required token missing: {token}")

forbidden = [
    "aio_multi_wait",
    "get_aio_debug_request_info",
    "kernel_iommu_copyin",
    "kernel_write",
    "kernel_copyin",
    "kernel_copyout",
    "mprotect(",
    "setuid(",
]
for token in forbidden:
    if token in text:
        raise SystemExit(f"FAIL: forbidden probe token present: {token}")

calls = []
for line in text.splitlines():
    s = line.strip()
    if s.startswith("jit_write"):
        calls.append(s)
if calls != ["jit_write32(errno_ptr, 0)"]:
    raise SystemExit(f"FAIL: unexpected JIT write set: {calls}")

print("PASS: public probe policy check")
