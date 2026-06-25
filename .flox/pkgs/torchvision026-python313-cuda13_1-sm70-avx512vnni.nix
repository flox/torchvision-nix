# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA V100, Titan V (SM70) — AVX-512 VNNI — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "70"; isa = "avx512vnni"; cudaVersion = "13_1"; }
