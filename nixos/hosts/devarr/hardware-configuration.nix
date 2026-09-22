# STUB — this file only exists so the flake evaluates outside of a real
# NixOS install. Replace it entirely with the output of:
#
#   nixos-generate-config --root /mnt
#
# run on the actual target machine/VM during install. Do not hand-edit
# the generated version beyond what nixos-generate-config produces.
{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ ];
  boot.kernelModules = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
