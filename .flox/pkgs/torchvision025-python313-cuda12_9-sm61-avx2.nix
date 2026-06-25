# TorchVision 0.25 (↔ PyTorch 2.10) for NVIDIA GTX 1070, 1080, 1080 Ti, P40 (SM61) — AVX2 — CUDA 12.9 (driver 560+)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cuda"; sm = "61"; isa = "avx2"; cudaVersion = "12_9"; }
