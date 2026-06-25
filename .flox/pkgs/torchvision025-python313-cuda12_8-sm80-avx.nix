# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA A100, A30 (SM80) — AVX — CUDA 12.8 (driver 550+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "80"; isa = "avx"; cudaVersion = "12_8"; }
