# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA T4, RTX 2080 Ti (SM75) — ARMv8.2 — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "75"; isa = "armv8_2"; cudaVersion = "13_0"; }
