# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA R100, RTX 5090 (SM120) — ARMv9 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "armv9"; cudaVersion = "12_8"; }
