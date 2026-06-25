# TorchVision 0.25 (↔ PyTorch 2.10) with MPS GPU acceleration for Apple Silicon — Python 3.13
{ pkgs ? import <nixpkgs> {} }:
import ./lib/mkTorchVision.nix { tvVersion = "0.25"; pythonVersion = "313"; backend = "mps"; }
