# TorchVision 0.27 (↔ PyTorch 2.12) for NVIDIA A100, A30 (SM80) — AVX-512 VNNI — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "avx512vnni"; cudaVersion = "12_8"; }
