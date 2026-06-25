# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA DRIVE Thor (SM110) — ARMv9 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "110"; isa = "armv9"; cudaVersion = "13_1"; }
