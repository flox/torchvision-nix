# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA A100, A30 (SM80) — AVX2 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "avx2"; cudaVersion = "12_9"; }
