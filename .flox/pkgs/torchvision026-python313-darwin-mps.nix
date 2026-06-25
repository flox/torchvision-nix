# TorchVision 0.26 (↔ PyTorch 2.11) with MPS GPU acceleration for Apple Silicon — Python 3.13
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.26"; pythonVersion = "313"; backend = "mps"; }
