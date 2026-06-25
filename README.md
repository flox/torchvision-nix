# TorchVision Custom Build Environment

This Flox environment builds custom TorchVision variants matched to specific [`pytorch-nix`](../pytorch-nix) variants for targeted optimizations. Every torchvision variant links against the matching pytorch-nix torch build so the torch/torchvision ABI stays consistent.

## Overview

TorchVision ships CUDA kernels for `roi_align`, NMS, and similar primitives. Just like `pytorch-nix`, this repo builds **targeted variants** instead of the everything-included upstream wheels:

- **Smaller binaries** — Only kernels for your target GPU architecture
- **ABI-matched torch** — Each variant imports the matching `pytorch-nix` wrapper, eliminating torch/torchvision skew
- **Reproducible** — Pinned nixpkgs revisions, pinned upstream torchvision tags via `sourceOverride`

## Variant Coverage

| TorchVision | Matching PyTorch | Python | CUDA | GPU Architectures | Variants |
|-------------|------------------|--------|------|-------------------|----------|
| 0.25.0      | 2.10.0           | 3.13   | 12.8, 12.9, 13.0, 13.1 | SM61–SM121 | 265 |
| 0.26.0      | 2.11.0           | 3.13   | 12.8, 12.9, 13.0, 13.1 | SM61–SM121 | 265 |
| 0.27.1      | 2.12.1           | 3.13   | 12.8, 12.9, 13.0, 13.1 | SM61–SM121 | 265 |
| **Total**   |                  |        |                        |            | **795** |

SM61 (Pascal) is excluded from CUDA 13.0 and 13.1 variants — CUDA 13.0 nvcc removed `compute_61`. See the per-CUDA matrix docs for the explicit exclusions.

### Detailed Build Matrices

- **TorchVision 0.25**: [CUDA 12.8](docs/matrices/torchvision-0.25-cuda-12.8.md) · [CUDA 12.9](docs/matrices/torchvision-0.25-cuda-12.9.md) · [CUDA 13.0](docs/matrices/torchvision-0.25-cuda-13.0.md) · [CUDA 13.1](docs/matrices/torchvision-0.25-cuda-13.1.md)
- **TorchVision 0.26**: [CUDA 12.8](docs/matrices/torchvision-0.26-cuda-12.8.md) · [CUDA 12.9](docs/matrices/torchvision-0.26-cuda-12.9.md) · [CUDA 13.0](docs/matrices/torchvision-0.26-cuda-13.0.md) · [CUDA 13.1](docs/matrices/torchvision-0.26-cuda-13.1.md)
- **TorchVision 0.27**: [CUDA 12.8](docs/matrices/torchvision-0.27-cuda-12.8.md) · [CUDA 12.9](docs/matrices/torchvision-0.27-cuda-12.9.md) · [CUDA 13.0](docs/matrices/torchvision-0.27-cuda-13.0.md) · [CUDA 13.1](docs/matrices/torchvision-0.27-cuda-13.1.md)

## Dependency on `pytorch-nix`

**Critical**: This repo is a sibling of `/home/daedalus/dev/builds/pytorch-nix` and must remain so. Each torchvision wrapper imports the matching pytorch-nix wrapper at build time. The default `pytorchNixRoot` argument in `lib/mkTorchVision.nix` resolves to `../../../../pytorch-nix`, i.e. the sibling directory.

Version pairing:

| TorchVision | imports PyTorch wrapper |
|-------------|-------------------------|
| 0.25.0      | `pytorch210-python313-cuda{cuda}-sm{sm}-{isa}` |
| 0.26.0      | `pytorch211-python313-cuda{cuda}-sm{sm}-{isa}` |
| 0.27.1      | `pytorch212-python313-cuda{cuda}-sm{sm}-{isa}` |

Build the matching pytorch-nix variant **first**, then the torchvision variant.

## Quick Start

```bash
# Build a specific torchvision variant
flox build torchvision025-python313-cuda12_9-sm90-avx512

# Result is in ./result-torchvision025-python313-cuda12_9-sm90-avx512/
```

Each recipe is a standalone Nix expression, so plain Nix works too:

```bash
nix-build .flox/pkgs/torchvision025-python313-cuda12_9-sm90-avx512.nix
```

## Naming Convention

```
torchvision{tvShort}-python{pyver}-{backend}-{isa}.nix
torchvision{tvShort}-python{pyver}-cuda{cudaver}-sm{sm}-{isa}.nix
torchvision{tvShort}-python{pyver}-darwin-mps.nix
```

- `{tvShort}`: TorchVision minor version without dots (`025`, `026`, `027`)
- `{pyver}`: Python minor version (`313`)
- `{cudaver}`: CUDA version with underscore (`12_8`, `12_9`, `13_0`, `13_1`)
- `{sm}`: SM architecture number (`61`, `70`, `75`, `80`, `86`, `89`, `90`, `100`, `103`, `110`, `120`, `121`)
- `{isa}`: CPU ISA (`avx`, `avx2`, `avx512`, `avx512bf16`, `avx512vnni`, `armv8_2`, `armv9`)

## GPU Architecture Reference

| SM | Architecture | GPUs | Min Driver | CUDA Versions |
|----|-------------|------|------------|---------------|
| SM121 | Vera Rubin Ultra | R100 Ultra | 590+ | 13.0, 13.1 (aarch64-only) |
| SM120 | Vera Rubin | R100, RTX 5090 | 550+ | 12.8, 12.9, 13.0, 13.1 |
| SM110 | DRIVE Thor | DRIVE Thor | 580+ | 13.0, 13.1 (aarch64-only) |
| SM103 | Blackwell Ultra | B300, GB300 | 560+ | 12.9, 13.0, 13.1 |
| SM100 | Blackwell | B200, GB200 | 550+ | 12.8, 12.9, 13.0, 13.1 |
| SM90 | Hopper | H100, H200, L40S | 525+ | 12.8, 12.9, 13.0, 13.1 |
| SM89 | Ada Lovelace | L40, RTX 4090 | 520+ | 12.8, 12.9, 13.0, 13.1 |
| SM86 | Ampere | A40, RTX 3090 | 470+ | 12.8, 12.9, 13.0, 13.1 |
| SM80 | Ampere | A100, A30 | 450+ | 12.8, 12.9, 13.0, 13.1 |
| SM75 | Turing | T4, RTX 2080 Ti | 418+ | 12.8, 12.9, 13.0, 13.1 |
| SM70 | Volta | V100, Titan V | 390+ | 12.8, 12.9, 13.0, 13.1 |
| SM61 | Pascal | GTX 1070/1080/1080 Ti, P40 | 390+ | 12.8, 12.9 |

## CPU ISA Guide

| ISA | Hardware | Use Case |
|-----|----------|----------|
| `avx` | Sandy Bridge+ (2011+) | Maximum compatibility |
| `avx2` | Haswell+ (2013+) | Broad x86-64 compatibility |
| `avx512` | Skylake-X+ (2017+) | General FP32 workloads |
| `avx512bf16` | Cooper Lake+ (2020+) | BF16 mixed-precision training |
| `avx512vnni` | Skylake-SP+ (2017+) | INT8 quantized inference |
| `armv8_2` | Graviton2, older ARM | ARM servers without SVE2 |
| `armv9` | Grace, Graviton3+ | Modern ARM with SVE2 |

## Architecture

```
torchvision-nix/
├── .flox/
│   ├── env/manifest.toml              # Build environment definition
│   └── pkgs/
│       ├── lib/                        # Shared parametric builders
│       │   ├── cpu-isa.nix             # ISA → compiler flags
│       │   ├── gpu-metadata.nix        # SM → capability, GPU names, constraints
│       │   ├── cuda-metadata.nix       # CUDA version → overlay, min driver
│       │   ├── torchvision-metadata.nix  # (tvVer, pyVer) → nixpkgs pin, ptVersion, source
│       │   ├── build-fixups.nix        # Source-override overlay (substitutes torch + torchvision)
│       │   └── mkTorchVision.nix       # Main parametric TorchVision builder
│       └── torchvision{025,026,027}-python313-*.nix  # 3-line wrapper files (generated)
├── scripts/
│   ├── generate-variants.sh           # Generates all wrapper files
│   └── generate-matrices.sh           # Generates per-CUDA matrix docs
├── docs/matrices/                     # Per-(TorchVision, CUDA) build matrices
└── README.md
```

### How It Works

Each wrapper file is 3 lines — a comment, a function signature, and an import:

```nix
# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA H100, H200, L40S (SM90) — AVX-512 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "90"; isa = "avx512"; cudaVersion = "12_9"; }
```

The `mkTorchVision.nix` parametric builder:
1. Looks up ISA config, GPU metadata, CUDA metadata, and TorchVision metadata from the data tables.
2. Resolves the correct nixpkgs pin (may vary by CUDA version).
3. Imports the matching pytorch-nix wrapper as the substituted `torch`.
4. Instantiates nixpkgs with a Python-packages overlay that substitutes both `torch` (from pytorch-nix) and `torchvision` (with the upstream `sourceOverride`).
5. Applies CUDA arch flags via `TORCH_CUDA_ARCH_LIST`.

### Regenerating Variants

After modifying metadata or adding a new TorchVision version:

```bash
bash scripts/generate-variants.sh   # → Generated 795 variant files
bash scripts/generate-matrices.sh   # → Generated 12 matrix files
```

## Variant Selection Guide

**1. Which GPU do you have?**
```bash
nvidia-smi --query-gpu=name,compute_cap --format=csv,noheader
```

**2. Which CPU ISA?**
```bash
lscpu | grep -E 'avx|sve'
```

**3. Pick the right variant** (mirrors pytorch-nix):
- H100 datacenter (x86) → `sm90-avx512`
- RTX 5090 workstation → `sm120-avx512` or `sm120-avx2`
- AWS Graviton3 + H100 → `sm90-armv9`
- Apple Silicon → `darwin-mps`
- CPU inference (datacenter) → `cpu-avx512` or `cpu-avx512vnni`
- CPU inference (broad compat) → `cpu-avx2`

## Publishing

Flox users can publish prebuilt packages to a private catalog:

```bash
flox publish -o <your-org> torchvision025-python313-cuda12_9-sm90-avx512
flox install <your-org>/torchvision025-python313-cuda12_9-sm90-avx512
```

## License

Build environment configuration is MIT licensed. TorchVision itself is BSD-3-Clause licensed.
