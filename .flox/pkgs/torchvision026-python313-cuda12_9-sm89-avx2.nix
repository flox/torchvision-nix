# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA L40, RTX 4090 (SM89) — AVX2 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "89"; isa = "avx2"; cudaVersion = "12_9"; }
