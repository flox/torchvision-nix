# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA R100, RTX 5090 (SM120) — AVX — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "avx"; cudaVersion = "12_8"; }
