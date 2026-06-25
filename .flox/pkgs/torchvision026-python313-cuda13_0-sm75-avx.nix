# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA T4, RTX 2080 Ti (SM75) — AVX — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "75"; isa = "avx"; cudaVersion = "13_0"; }
