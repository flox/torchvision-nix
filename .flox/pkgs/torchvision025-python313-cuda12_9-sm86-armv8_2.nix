# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA A40, RTX 3090 (SM86) — ARMv8.2 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "86"; isa = "armv8_2"; cudaVersion = "12_9"; }
