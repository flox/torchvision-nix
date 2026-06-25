# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA A100 (ARM) (SM80) — ARMv9 — CUDA 13.0 (driver 580+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "armv9"; cudaVersion = "13_0"; }
