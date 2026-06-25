# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA GH200 (SM90) — ARMv8.2 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "90"; isa = "armv8_2"; cudaVersion = "12_8"; }
