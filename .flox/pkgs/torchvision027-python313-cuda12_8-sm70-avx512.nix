# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA V100, Titan V (SM70) — AVX-512 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "70"; isa = "avx512"; cudaVersion = "12_8"; }
