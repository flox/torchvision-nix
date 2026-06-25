# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA V100, Titan V (SM70) — AVX2 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "70"; isa = "avx2"; cudaVersion = "12_9"; }
