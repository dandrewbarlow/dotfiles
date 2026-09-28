# home-manager additions for the desktop profile: GUI apps and their
# dotfiles. Imported by ../modules/desktop.nix on top of common.nix.
{ config, pkgs, link, ... }:

{
  xdg.configFile = {
    "hypr".source = link "dot-config/hypr";
    "hyprland".source = link "dot-config/hyprland";
    "waybar".source = link "dot-config/waybar";
    "kitty".source = link "dot-config/kitty";
    "mpv".source = link "dot-config/mpv";
    "rofi".source = link "dot-config/rofi";
    "ghostty".source = link "dot-config/ghostty";
    "kando".source = link "dot-config/kando";
    "herdr".source = link "dot-config/herdr";
  };

  home.packages = with pkgs; [
    # CODING
    emacs

    # THEMING
    papirus-icon-theme

    # PRODUCTIVITY
    thunderbird

    # INTERNET
    qbittorrent
    firefox

    # MEDIA
    cmus
    feh
    mpv
    spotify
    zathura

    # SYSTEM
    kdePackages.dolphin # dolphin
    kitty
  ];
}
