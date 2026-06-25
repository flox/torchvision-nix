# TorchVision 0.25 (↔ PyTorch 2.10) CPU-only — ARMv8.2 (aarch64)
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "cpu"; isa = "armv8_2"; }
