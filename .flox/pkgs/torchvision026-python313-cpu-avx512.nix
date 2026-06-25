# TorchVision 0.26 (↔ PyTorch 2.11) CPU-only — AVX-512 (x86_64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cpu"; isa = "avx512"; }
