# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA V100, Titan V (SM70) — AVX-512 BF16 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "70"; isa = "avx512bf16"; cudaVersion = "13_1"; }
