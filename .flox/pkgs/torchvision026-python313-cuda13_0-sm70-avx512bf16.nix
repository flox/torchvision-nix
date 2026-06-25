# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA V100, Titan V (SM70) — AVX-512 BF16 — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "70"; isa = "avx512bf16"; cudaVersion = "13_0"; }
