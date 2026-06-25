# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA L40, RTX 4090 (SM89) — AVX-512 VNNI — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "89"; isa = "avx512vnni"; cudaVersion = "13_0"; }
