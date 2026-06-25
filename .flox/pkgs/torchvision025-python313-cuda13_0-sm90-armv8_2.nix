# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA GH200 (SM90) — ARMv8.2 — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "90"; isa = "armv8_2"; cudaVersion = "13_0"; }
