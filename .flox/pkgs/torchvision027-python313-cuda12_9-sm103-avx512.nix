# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA B300, GB300 (SM103) — AVX-512 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "103"; isa = "avx512"; cudaVersion = "12_9"; }
