# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA L40, RTX 4090 (SM89) — AVX — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "89"; isa = "avx"; cudaVersion = "13_1"; }
