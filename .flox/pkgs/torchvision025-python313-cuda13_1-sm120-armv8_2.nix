# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA R100, RTX 5090 (SM120) — ARMv8.2 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "120"; isa = "armv8_2"; cudaVersion = "13_1"; }
