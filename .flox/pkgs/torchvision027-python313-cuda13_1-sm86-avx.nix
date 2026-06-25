# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA A40, RTX 3090 (SM86) — AVX — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "86"; isa = "avx"; cudaVersion = "13_1"; }
