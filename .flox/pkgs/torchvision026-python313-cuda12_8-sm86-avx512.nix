# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA A40, RTX 3090 (SM86) — AVX-512 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "86"; isa = "avx512"; cudaVersion = "12_8"; }
