# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA B200, GB200 (SM100) — AVX — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "100"; isa = "avx"; cudaVersion = "12_8"; }
