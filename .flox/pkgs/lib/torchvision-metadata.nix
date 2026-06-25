# TorchVision metadata: (tvVersion, pythonVersion) → build configuration.
# Keyed by "majorMinor-pythonMinor" (e.g., "0.25-313").
#
# Each entry provides everything needed to instantiate nixpkgs and build
# torchvision for that combination. The generator script reads these entries
# to produce all valid (SM, ISA, CUDA) wrapper files.
#
# Hashes prefetched 2026-06-23 via nix-prefetch-git --fetch-submodules.
{
  # ── TorchVision 0.25.x (↔ PyTorch 2.10.x) ───────────────────────────
  "0.25-313" = {
    tvVersion = "0.25.0";
    ptVersion = "2.10.0";
    nixpkgsPin = "0182a361324364ae3f436a63005877674cf45efb";
    pythonAttr = "python3Packages";
    sourceOverride = {
      version = "0.25.0";
      owner = "pytorch";
      repo  = "vision";
      rev   = "v0.25.0";
      hash  = "sha256-oktJHcT6T4f58pUO+HSBpbyS1ISH3zDlTsXQh6PcMy4=";
    };
    cudaVersions = [ "12_8" "12_9" "13_0" "13_1" ];
    # Per-CUDA-version nixpkgs pin overrides (reuse pytorch-nix 2.10's pins)
    cudaPinOverrides = {
      "13_0" = "6a030d535719c5190187c4cec156f335e95e3211";
      "13_1" = "2017d6d515f8a7b289fe06d3a880a7ec588c3900";
    };
    cpuPin = "6a030d535719c5190187c4cec156f335e95e3211";
  };

  # ── TorchVision 0.26.x (↔ PyTorch 2.11.x) ───────────────────────────
  "0.26-313" = {
    tvVersion = "0.26.0";
    ptVersion = "2.11.0";
    nixpkgsPin = "0182a361324364ae3f436a63005877674cf45efb";
    pythonAttr = "python3Packages";
    sourceOverride = {
      version = "0.26.0";
      owner = "pytorch";
      repo  = "vision";
      rev   = "v0.26.0";
      hash  = "sha256-FOdDGY3v8yWBhtNo9tZP79/xwrc7AoIY5Y1ZABzWe6g=";
    };
    cudaVersions = [ "12_8" "12_9" "13_0" "13_1" ];
    cudaPinOverrides = {
      "13_0" = "6a030d535719c5190187c4cec156f335e95e3211";
      "13_1" = "2017d6d515f8a7b289fe06d3a880a7ec588c3900";
    };
    cpuPin = "6a030d535719c5190187c4cec156f335e95e3211";
  };

  # ── TorchVision 0.27.x (↔ PyTorch 2.12.x) ───────────────────────────
  "0.27-313" = {
    tvVersion = "0.27.1";
    ptVersion = "2.12.1";
    nixpkgsPin = "0182a361324364ae3f436a63005877674cf45efb";
    pythonAttr = "python3Packages";
    sourceOverride = {
      version = "0.27.1";
      owner = "pytorch";
      repo  = "vision";
      rev   = "v0.27.1";
      hash  = "sha256-XFbFC77UHC9WVhZepEK+7JpWbTpTrGizx8NMcRlwX74=";
    };
    cudaVersions = [ "12_8" "12_9" "13_0" "13_1" ];
    cudaPinOverrides = {
      "13_0" = "6a030d535719c5190187c4cec156f335e95e3211";
      "13_1" = "2017d6d515f8a7b289fe06d3a880a7ec588c3900";
    };
    cpuPin = "6a030d535719c5190187c4cec156f335e95e3211";
  };
}
