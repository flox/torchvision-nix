# TorchVision 0.26 (↔ PyTorch 2.11) CPU-only — ARMv8.2 (aarch64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "cpu"; isa = "armv8_2"; }
