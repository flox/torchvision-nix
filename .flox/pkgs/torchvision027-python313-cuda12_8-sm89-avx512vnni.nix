# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA L40, RTX 4090 (SM89) — AVX-512 VNNI — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "89"; isa = "avx512vnni"; cudaVersion = "12_8"; }
