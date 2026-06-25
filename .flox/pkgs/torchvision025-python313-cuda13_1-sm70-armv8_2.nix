# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA V100, Titan V (SM70) — ARMv8.2 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "70"; isa = "armv8_2"; cudaVersion = "13_1"; }
