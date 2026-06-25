# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA A40, RTX 3090 (SM86) — AVX2 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "86"; isa = "avx2"; cudaVersion = "13_1"; }
