# TorchVision 0.25 (↔ PyTorch 2.10) CPU-only — AVX-512 (x86_64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cpu"; isa = "avx512"; }
