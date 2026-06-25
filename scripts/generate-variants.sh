#!/usr/bin/env bash
set -euo pipefail

# Generate all TorchVision variant wrapper files.
# Each file is 3 lines: comment, function arg, import call.
#
# The variant matrix is computed from:
#   - torchvision-metadata.nix: (tvVersion, pythonVersion) → CUDA versions, matching ptVersion
#   - gpu-metadata.nix:         SM arch → allowed ISAs, CUDA version support
#   - cpu-isa.nix:              ISA key → platform

PKGS_DIR="$(cd "$(dirname "$0")/../.flox/pkgs" && pwd)"

# Clean existing variant files (preserve lib/ directory)
rm -f "$PKGS_DIR"/torchvision*.nix

# ── GPU metadata ──────────────────────────────────────────────────────
declare -A SM_CAPABILITY=(
  [61]="6.1" [70]="7.0" [75]="7.5" [80]="8.0" [86]="8.6"
  [89]="8.9" [90]="9.0" [100]="10.0" [103]="10.3"
  [110]="11.0" [120]="12.0" [121]="12.1"
)
declare -A SM_ARCH_NAME=(
  [61]="Pascal" [70]="Volta" [75]="Turing" [80]="Ampere" [86]="Ampere"
  [89]="Ada Lovelace" [90]="Hopper" [100]="Blackwell"
  [103]="Blackwell Ultra" [110]="DRIVE Thor" [120]="Vera Rubin"
  [121]="Vera Rubin Ultra"
)
declare -A SM_GPU_NAMES=(
  [61]="GTX 1070, 1080, 1080 Ti, P40" [70]="V100, Titan V"
  [75]="T4, RTX 2080 Ti" [80]="A100, A30"
  [86]="A40, RTX 3090" [89]="L40, RTX 4090"
  [90]="H100, H200, L40S" [100]="B200, GB200"
  [103]="B300, GB300" [110]="DRIVE Thor"
  [120]="R100, RTX 5090" [121]="R100 Ultra"
)
declare -A SM_AARCH64_GPU_NAMES=(
  [80]="A100 (ARM)" [90]="GH200" [100]="GB200" [103]="GB300"
)

# ── ISA display names ─────────────────────────────────────────────────
declare -A ISA_DISPLAY=(
  [avx]="AVX" [avx2]="AVX2" [avx512]="AVX-512"
  [avx512bf16]="AVX-512 BF16" [avx512vnni]="AVX-512 VNNI"
  [armv8_2]="ARMv8.2" [armv9]="ARMv9"
)

# ── ISA platform ──────────────────────────────────────────────────────
declare -A ISA_PLATFORM=(
  [avx]="x86_64" [avx2]="x86_64" [avx512]="x86_64"
  [avx512bf16]="x86_64" [avx512vnni]="x86_64"
  [armv8_2]="aarch64" [armv9]="aarch64"
)

# ── CUDA metadata ────────────────────────────────────────────────────
declare -A CUDA_DRIVER=( [12_8]="550" [12_9]="560" [13_0]="580" [13_1]="590" )
declare -A CUDA_DISPLAY=( [12_8]="12.8" [12_9]="12.9" [13_0]="13.0" [13_1]="13.1" )

# ── ISA lists ─────────────────────────────────────────────────────────
X86_ISAS=(avx avx2 avx512 avx512bf16 avx512vnni)
SM61_ISAS=(avx avx2)
AARCH64_ISAS=(armv8_2 armv9)

# SM architectures with aarch64 support and their ISAs
declare -A SM_AARCH64_ISAS=(
  [70]="armv8_2 armv9"
  [75]="armv8_2 armv9"
  [80]="armv8_2 armv9"
  [86]="armv8_2 armv9"
  [89]="armv8_2 armv9"
  [90]="armv8_2 armv9"
  [100]="armv8_2 armv9"
  [103]="armv8_2 armv9"
  [110]="armv8_2 armv9"
  [120]="armv8_2 armv9"
  [121]="armv8_2 armv9"
)

# SMs that are aarch64-only (no x86 variants)
declare -A SM_AARCH64_ONLY=( [110]=1 [121]=1 )

# CUDA version constraints per SM
declare -A SM_CUDA_VERSIONS=(
  [61]="12_8 12_9"
  [103]="12_9 13_0 13_1"
  [110]="13_0 13_1"
  [121]="13_0 13_1"
)

ALL_SMS=(61 70 75 80 86 89 90 100 103 110 120 121)

# ── TorchVision metadata ─────────────────────────────────────────────
# Format: "tvVer:pyVer:cudaVersions"
TV_COMBOS=(
  "0.25:313:12_8 12_9 13_0 13_1"
  "0.26:313:12_8 12_9 13_0 13_1"
  "0.27:313:12_8 12_9 13_0 13_1"
)

# tv minor → matching pytorch X.Y string (for comments)
declare -A TV_PT_VERSION=( [0.25]="2.10" [0.26]="2.11" [0.27]="2.12" )

count=0

# ── Helper: short torchvision version (0.25 → 025, 0.26 → 026) ──────
tv_short() {
  echo "$1" | tr -d '.'
}

# ── Helper: check if a CUDA version is valid for a given SM ──────────
sm_supports_cuda() {
  local sm="$1" cuda_ver="$2"
  if [[ -n "${SM_CUDA_VERSIONS[$sm]:-}" ]]; then
    local allowed
    read -ra allowed <<< "${SM_CUDA_VERSIONS[$sm]}"
    for v in "${allowed[@]}"; do
      [[ "$v" == "$cuda_ver" ]] && return 0
    done
    return 1
  fi
  return 0
}

# ── Helper: get GPU display name for a given SM and platform ─────────
gpu_display() {
  local sm="$1" plat="$2"
  if [[ "$plat" == "aarch64" && -n "${SM_AARCH64_GPU_NAMES[$sm]:-}" ]]; then
    echo "${SM_AARCH64_GPU_NAMES[$sm]}"
  else
    echo "${SM_GPU_NAMES[$sm]}"
  fi
}

# ── Generate all variants ────────────────────────────────────────────
for combo in "${TV_COMBOS[@]}"; do
  IFS=: read -r tv_ver py_ver cuda_vers <<< "$combo"
  read -ra cuda_list <<< "$cuda_vers"
  tv_s=$(tv_short "$tv_ver")
  pt_ver="${TV_PT_VERSION[$tv_ver]}"

  # ── CPU variants ───────────────────────────────────────────────────
  for isa in "${X86_ISAS[@]}"; do
    file="$PKGS_DIR/torchvision${tv_s}-python${py_ver}-cpu-${isa}.nix"
    cat > "$file" << EOF
# TorchVision ${tv_ver} (↔ PyTorch ${pt_ver}) CPU-only — ${ISA_DISPLAY[$isa]} (x86_64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "${tv_ver}"; pythonVersion = "${py_ver}"; backend = "cpu"; isa = "${isa}"; }
EOF
    count=$((count + 1))
  done

  for isa in "${AARCH64_ISAS[@]}"; do
    file="$PKGS_DIR/torchvision${tv_s}-python${py_ver}-cpu-${isa}.nix"
    cat > "$file" << EOF
# TorchVision ${tv_ver} (↔ PyTorch ${pt_ver}) CPU-only — ${ISA_DISPLAY[$isa]} (aarch64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "${tv_ver}"; pythonVersion = "${py_ver}"; backend = "cpu"; isa = "${isa}"; }
EOF
    count=$((count + 1))
  done

  # ── Darwin MPS variant ─────────────────────────────────────────────
  file="$PKGS_DIR/torchvision${tv_s}-python${py_ver}-darwin-mps.nix"
  cat > "$file" << EOF
# TorchVision ${tv_ver} (↔ PyTorch ${pt_ver}) with MPS GPU acceleration for Apple Silicon — Python ${py_ver:0:1}.${py_ver:1}
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "${tv_ver}"; pythonVersion = "${py_ver}"; backend = "mps"; }
EOF
  count=$((count + 1))

  # ── CUDA variants ──────────────────────────────────────────────────
  for cuda_ver in "${cuda_list[@]}"; do
    for sm in "${ALL_SMS[@]}"; do
      sm_supports_cuda "$sm" "$cuda_ver" || continue

      # x86_64 ISAs (unless SM is aarch64-only)
      if [[ -z "${SM_AARCH64_ONLY[$sm]:-}" ]]; then
        if [[ "$sm" == "61" ]]; then
          isas=("${SM61_ISAS[@]}")
        else
          isas=("${X86_ISAS[@]}")
        fi

        for isa in "${isas[@]}"; do
          gpu_name=$(gpu_display "$sm" "x86_64")
          file="$PKGS_DIR/torchvision${tv_s}-python${py_ver}-cuda${cuda_ver}-sm${sm}-${isa}.nix"
          cat > "$file" << EOF
# TorchVision ${tv_ver} (↔ PyTorch ${pt_ver}) for NVIDIA ${gpu_name} (SM${sm}) — ${ISA_DISPLAY[$isa]} — CUDA ${CUDA_DISPLAY[$cuda_ver]} (driver ${CUDA_DRIVER[$cuda_ver]}+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "${tv_ver}"; pythonVersion = "${py_ver}"; backend = "cuda"; sm = "${sm}"; isa = "${isa}"; cudaVersion = "${cuda_ver}"; }
EOF
          count=$((count + 1))
        done
      fi

      # aarch64 ISAs (only for SMs with ARM support)
      if [[ -n "${SM_AARCH64_ISAS[$sm]:-}" ]]; then
        read -ra arm_isas <<< "${SM_AARCH64_ISAS[$sm]}"
        gpu_name=$(gpu_display "$sm" "aarch64")

        for isa in "${arm_isas[@]}"; do
          file="$PKGS_DIR/torchvision${tv_s}-python${py_ver}-cuda${cuda_ver}-sm${sm}-${isa}.nix"
          cat > "$file" << EOF
# TorchVision ${tv_ver} (↔ PyTorch ${pt_ver}) for NVIDIA ${gpu_name} (SM${sm}) — ${ISA_DISPLAY[$isa]} — CUDA ${CUDA_DISPLAY[$cuda_ver]} (driver ${CUDA_DRIVER[$cuda_ver]}+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "${tv_ver}"; pythonVersion = "${py_ver}"; backend = "cuda"; sm = "${sm}"; isa = "${isa}"; cudaVersion = "${cuda_ver}"; }
EOF
          count=$((count + 1))
        done
      fi
    done
  done

done

echo "Generated $count variant files in $PKGS_DIR"
