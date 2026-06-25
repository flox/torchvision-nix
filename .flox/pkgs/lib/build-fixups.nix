# build-fixups.nix — version-specific build workarounds for torchvision.
#
# Returns an attrset with extra overlays, config, cmake flags, and shell
# snippets that must be applied for certain (tvVersion, cudaVersion)
# combinations.
#
# Much smaller than the pytorch-nix equivalent: torchvision doesn't need the
# CCCL shim or the magma clockrate patch — those concerns are torch's.
# Only the sourceOverride overlay (fetching torchvision from upstream) is
# needed when nixpkgs doesn't ship the requested version.
#
# Arguments:
#   tvConfig:      Entry from torchvision-metadata.nix
#   cudaVersion:   CUDA version string (e.g., "13_0") or null for CPU/MPS
#   torchOverride: A derivation to substitute for torch (the matching
#                  pytorch-nix variant). May be null for CPU/MPS where
#                  torch is also from pytorch-nix's CPU/MPS recipe.

{ tvConfig, cudaVersion, torchOverride }:

let
  sourceOverride = tvConfig.sourceOverride or null;
  hasSourceOverride = sourceOverride != null;

  isCuda13 = cudaVersion != null && builtins.match "13_.*" cudaVersion != null;

in {
  # ── Extra nixpkgs config ─────────────────────────────────────────────
  extraConfig =
    if hasSourceOverride && isCuda13
    then { allowBroken = true; }
    else {};

  # ── Extra overlays ──────────────────────────────────────────────────
  # Substitute the matching pytorch-nix torch build into the python
  # package set, and override torchvision's src/version to the upstream
  # tag specified by sourceOverride.
  extraOverlays =
    if hasSourceOverride then [
      (final: prev: {
        ${tvConfig.pythonAttr} = prev.${tvConfig.pythonAttr}.override {
          overrides = pfinal: pprev: {
            torch = torchOverride;
            torchvision = pprev.torchvision.overrideAttrs (oldAttrs: rec {
              version = sourceOverride.version;
              src = prev.fetchFromGitHub {
                inherit (sourceOverride) owner repo rev hash;
                fetchSubmodules = true;
              };
              patches = [];
              # Soften strict `--replace-fail` to `--replace-warn`, and
              # neutralize `rm cmake/Modules/FindCUDAToolkit.cmake` (mirrors
              # the pytorch-nix fix — harmless if the line isn't present).
              postPatch = builtins.replaceStrings
                [ "--replace-fail " "--replace "
                  "rm cmake/Modules/FindCUDAToolkit.cmake" ]
                [ "--replace-warn "  "--replace-warn "
                  ": # upstream rm cmake/Modules/FindCUDAToolkit.cmake (kept for 2.12 install rule)" ]
                (oldAttrs.postPatch or "");
            });
          };
        };
      })
    ] else if torchOverride != null then [
      (final: prev: {
        ${tvConfig.pythonAttr} = prev.${tvConfig.pythonAttr}.override {
          overrides = pfinal: pprev: { torch = torchOverride; };
        };
      })
    ] else [];

  # ── Extra cmake flags ───────────────────────────────────────────────
  extraCmakeFlags =
    if hasSourceOverride then [
      "-DTORCH_BUILD_VERSION=${sourceOverride.version}"
    ] else [];

  # ── Extra preConfigure shell ────────────────────────────────────────
  extraPreConfigure =
    if hasSourceOverride then ''
      export BUILD_VERSION=${sourceOverride.version}
      echo "${sourceOverride.version}" > version.txt
    '' else "";

  # ── Whether to clear patches ────────────────────────────────────────
  clearPatches = hasSourceOverride;
}
