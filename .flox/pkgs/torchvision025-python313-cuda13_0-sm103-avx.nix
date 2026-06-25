# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA B300, GB300 (SM103) — AVX — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "103"; isa = "avx"; cudaVersion = "13_0"; }
