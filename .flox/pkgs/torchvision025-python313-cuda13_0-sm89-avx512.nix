# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA L40, RTX 4090 (SM89) — AVX-512 — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "89"; isa = "avx512"; cudaVersion = "13_0"; }
