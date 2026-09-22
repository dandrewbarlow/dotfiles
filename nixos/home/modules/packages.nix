# Translated from ../../../package-lists/packages.conf.
#
# A few packages from that list are intentionally NOT here because they're
# better handled elsewhere:
#   - steam -> programs.steam.enable in hosts/devarr/configuration.nix
#     (needs setuid wrappers, doesn't work as a plain home package)
#   - zsh   -> programs.zsh.enable + users.users.andrew.shell in
#     hosts/devarr/configuration.nix
#   - ufw   -> replaced by networking.firewall.enable (NixOS's own firewall)
#
# A few names changed vs. the Debian/apt names in packages.conf:
#   - node        -> nodejs
#   - make        -> gnumake
#   - fortune     -> fortune-mod
#   - dolphin     -> kdePackages.dolphin
#   - neofetch    -> fastfetch (neofetch is unmaintained upstream)
#   - youtube-dl  -> yt-dlp (youtube-dl is largely unmaintained; yt-dlp is
#     the actively developed fork/replacement)
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CODING
    emacs
    gcc
    gdb
    git
    go
    lazygit
    gnumake
    neovim
    nodejs
    python3
    shellcheck

    # FUN
    cmatrix
    cowsay
    fortune-mod

    # THEMING
    papirus-icon-theme

    # PRODUCTIVITY
    pandoc
    thunderbird
    syncthing

    # INTERNET
    qbittorrent
    firefox

    # MEDIA
    cmus
    feh
    ffmpeg
    mpv
    spotify
    yt-dlp
    zathura

    # SYSTEM
    bat
    kdePackages.dolphin
    eza
    fd
    fzf
    htop
    kitty
    fastfetch
    p7zip
    tmux
    tree
    wget
    yazi
  ];
}
