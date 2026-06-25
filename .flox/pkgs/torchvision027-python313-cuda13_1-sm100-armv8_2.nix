# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA GB200 (SM100) — ARMv8.2 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "100"; isa = "armv8_2"; cudaVersion = "13_1"; }
