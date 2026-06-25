# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA H100, H200, L40S (SM90) — AVX — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "90"; isa = "avx"; cudaVersion = "13_1"; }
