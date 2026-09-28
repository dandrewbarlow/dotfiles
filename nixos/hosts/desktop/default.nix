# Host "desktop" — a generic desktop-profile machine. For a real machine, copy
# this directory to hosts/<name>/ and register it in ../../flake.nix.
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # UEFI. For legacy BIOS use boot.loader.grub instead.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Did you read the comment? Set to the release this machine was first
  # installed with, then leave it alone.
  system.stateVersion = "26.05";
}
