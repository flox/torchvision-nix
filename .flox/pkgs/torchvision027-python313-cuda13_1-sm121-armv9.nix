# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA R100 Ultra (SM121) — ARMv9 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "121"; isa = "armv9"; cudaVersion = "13_1"; }
