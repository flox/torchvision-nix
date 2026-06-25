# TorchVision 0.27 (↔ PyTorch 2.12) with MPS GPU acceleration for Apple Silicon — Python 3.13
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.27"; pythonVersion = "313"; backend = "mps"; }
