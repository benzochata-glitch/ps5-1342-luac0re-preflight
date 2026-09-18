# Contributing

Contributions are welcome when they remain inside this repository's narrow
scope: safe, exact-target userland compatibility measurement.

Accepted:
- clearer logging
- parser/reporting improvements
- fail-closed checks
- result-schema improvements
- reproducibility documentation

Out of scope:
- kernel exploit implementation
- UAF/race payloads
- heap spray/reclaim
- arbitrary kernel read/write
- IOMMU/TMR/VMCB modification
- hypervisor exploit code
- persistence/internal-storage modification

Keep result claims narrower than the evidence supports.
