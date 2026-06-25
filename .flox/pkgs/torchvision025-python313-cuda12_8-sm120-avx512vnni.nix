# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA R100, RTX 5090 (SM120) — AVX-512 VNNI — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "avx512vnni"; cudaVersion = "12_8"; }
