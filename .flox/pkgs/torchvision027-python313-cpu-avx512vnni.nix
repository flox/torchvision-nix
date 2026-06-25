# TorchVision 0.27 (↔ PyTorch 2.12) CPU-only — AVX-512 VNNI (x86_64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cpu"; isa = "avx512vnni"; }
