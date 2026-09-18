from pathlib import Path
import hashlib

root = Path(__file__).resolve().parents[1]
errors = []

for line in (root / "SHA256SUMS.txt").read_text(encoding="utf-8").splitlines():
    if not line.strip():
        continue
    expected, rel = line.split("  ", 1)
    p = root / rel
    if not p.exists():
        errors.append(f"missing: {rel}")
        continue
    got = hashlib.sha256(p.read_bytes()).hexdigest()
    if got != expected:
        errors.append(f"mismatch: {rel}")

if errors:
    for e in errors:
        print("FAIL:", e)
    raise SystemExit(1)

print("PASS: all release checksums match")
