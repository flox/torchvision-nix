# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA GH200 (SM90) — ARMv9 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "90"; isa = "armv9"; cudaVersion = "12_8"; }
