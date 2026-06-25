# TorchVision 0.27 (↔ PyTorch 2.12) CPU-only — AVX2 (x86_64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cpu"; isa = "avx2"; }
