# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA B300, GB300 (SM103) — AVX2 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "103"; isa = "avx2"; cudaVersion = "13_1"; }
