# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA A100 (ARM) (SM80) — ARMv8.2 — CUDA 13.1 (driver 590+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "armv8_2"; cudaVersion = "13_1"; }
