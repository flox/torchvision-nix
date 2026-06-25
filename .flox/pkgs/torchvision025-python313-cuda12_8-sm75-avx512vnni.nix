# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA T4, RTX 2080 Ti (SM75) — AVX-512 VNNI — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "75"; isa = "avx512vnni"; cudaVersion = "12_8"; }
