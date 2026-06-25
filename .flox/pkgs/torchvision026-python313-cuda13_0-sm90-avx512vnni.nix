# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA H100, H200, L40S (SM90) — AVX-512 VNNI — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "90"; isa = "avx512vnni"; cudaVersion = "13_0"; }
