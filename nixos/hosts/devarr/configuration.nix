# System-level configuration for host "devarr".
#
# This targets the same machine currently running Debian (see hostname),
# for an eventual NixOS migration. Nothing here is applied until you
# actually run `nixos-rebuild switch --flake .#devarr` on a NixOS system.
{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # TODO: confirm bootloader once this is run on real hardware/a VM.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "devarr";
  networking.networkmanager.enable = true;

  # TODO: adjust to actual timezone/locale.
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew Barlow";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # Desktop: Hyprland, matching dot-config/hypr + dot-config/waybar.
  programs.hyprland.enable = true;
  xdg.portal.enable = true;

  # steam needs setuid wrappers, so it's declared at system level rather
  # than as a home-manager package (was in package-lists/packages.conf GAMING).
  programs.steam.enable = true;

  # NixOS's built-in firewall replaces ufw from package-lists/packages.conf.
  networking.firewall.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; # needed for spotify, steam, etc.

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  # Did you read the comment? Bump this only on a deliberate, tested upgrade.
  system.stateVersion = "25.05";
}
