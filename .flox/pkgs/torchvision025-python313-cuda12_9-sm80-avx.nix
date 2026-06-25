# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA A100, A30 (SM80) — AVX — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "avx"; cudaVersion = "12_9"; }
