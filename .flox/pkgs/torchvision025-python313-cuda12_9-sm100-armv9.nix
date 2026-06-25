# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA GB200 (SM100) — ARMv9 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "100"; isa = "armv9"; cudaVersion = "12_9"; }
