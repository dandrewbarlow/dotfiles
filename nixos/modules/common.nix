# System config shared by every host, regardless of profile.
# Machine-specific bits (bootloader, hardware) live in hosts/<name>/.
{ config, pkgs, inputs, ... }:

{
  networking.networkmanager.enable = true;

  # TODO: adjust to actual timezone/locale.
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew Barlow";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  home-manager.users.andrew = import ../home/common.nix;

  # NixOS's built-in firewall replaces ufw from package-lists/packages.conf.
  networking.firewall.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; # needed for spotify, steam, etc.

  environment.systemPackages = with pkgs; [
    git
    vim
  ];
}
