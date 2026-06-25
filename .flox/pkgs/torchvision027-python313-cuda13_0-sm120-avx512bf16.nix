# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA R100, RTX 5090 (SM120) — AVX-512 BF16 — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "avx512bf16"; cudaVersion = "13_0"; }
