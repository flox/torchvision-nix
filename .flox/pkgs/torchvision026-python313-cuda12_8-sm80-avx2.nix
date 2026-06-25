# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA A100, A30 (SM80) — AVX2 — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "avx2"; cudaVersion = "12_8"; }
