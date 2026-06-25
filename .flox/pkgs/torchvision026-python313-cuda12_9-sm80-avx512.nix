# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA A100, A30 (SM80) — AVX-512 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "avx512"; cudaVersion = "12_9"; }
