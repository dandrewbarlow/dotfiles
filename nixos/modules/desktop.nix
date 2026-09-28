# Profile: full graphical user environment (Hyprland, matching
# dot-config/hypr + dot-config/waybar).
{ config, pkgs, ... }:

{
  users.users.andrew.extraGroups = [ "video" "audio" ];

  programs.hyprland.enable = true;
  xdg.portal.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # steam needs setuid wrappers, so it's declared at system level rather
  # than as a home-manager package (was in package-lists/packages.conf GAMING).
  programs.steam.enable = true;

  home-manager.users.andrew.imports = [ ../home/desktop.nix ];
}
