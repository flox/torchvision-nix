# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA R100, RTX 5090 (SM120) — ARMv9 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "armv9"; cudaVersion = "12_9"; }
