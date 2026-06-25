# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA GH200 (SM90) — ARMv9 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "90"; isa = "armv9"; cudaVersion = "12_9"; }
