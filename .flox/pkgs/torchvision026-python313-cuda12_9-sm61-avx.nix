# TorchVision 0.26 (↔ PyTorch 2.11) for NVIDIA GTX 1070, 1080, 1080 Ti, P40 (SM61) — AVX — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cuda"; sm = "61"; isa = "avx"; cudaVersion = "12_9"; }
