# home-manager additions for the desktop profile: GUI apps and their
# dotfiles. Imported by ../modules/desktop.nix on top of common.nix.
{ config, pkgs, link, ... }:

{
  xdg.configFile = {
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
    kitty
  ];
}
