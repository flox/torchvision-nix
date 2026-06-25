# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA R100, RTX 5090 (SM120) — AVX-512 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "avx512"; cudaVersion = "12_8"; }
