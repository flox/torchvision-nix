# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA A40, RTX 3090 (SM86) — AVX2 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "86"; isa = "avx2"; cudaVersion = "12_8"; }
