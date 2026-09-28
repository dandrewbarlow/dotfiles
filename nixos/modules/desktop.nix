# Profile: full graphical user environment (KDE Plasma 6).
{ config, pkgs, ... }:

{
  users.users.andrew.extraGroups = [ "video" "audio" ];

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

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
