# TorchVision 0.27 (↔ PyTorch 2.12) CPU-only — ARMv8.2 (aarch64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "cpu"; isa = "armv8_2"; }
