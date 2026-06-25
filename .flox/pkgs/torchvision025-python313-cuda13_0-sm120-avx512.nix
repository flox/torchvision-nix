# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA R100, RTX 5090 (SM120) — AVX-512 — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "avx512"; cudaVersion = "13_0"; }
