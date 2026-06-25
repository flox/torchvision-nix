# TorchVision 0.26 (↔ PyTorch 2.11) CPU-only — AVX2 (x86_64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cpu"; isa = "avx2"; }
