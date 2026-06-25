# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA V100, Titan V (SM70) — ARMv8.2 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "70"; isa = "armv8_2"; cudaVersion = "12_9"; }
