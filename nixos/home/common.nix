# home-manager config shared by every profile: shell, CLI tools, and
# symlinks for terminal-side dotfiles. GUI stuff lives in desktop.nix.
#
# Dotfiles are linked out-of-store back into ~/.dotfiles, the same way
# `stow . --dotfiles` (see ../../CLAUDE.md) would, so editing a file there
# takes effect immediately without a rebuild. The repo must be cloned to
# ~/.dotfiles for these links to resolve.
{ config, pkgs, inputs, ... }:

let
  link = path:
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${path}";
in
{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  _module.args.link = link;

  home.file = {
    ".zshrc".source = link "dot-zshrc";
    ".scripts".source = link "dot-scripts";
    ".oh-my-zsh".source = link "dot-oh-my-zsh";
    # oh-my-zsh itself; ~/.oh-my-zsh above is only our custom plugins
    ".local/share/oh-my-zsh".source = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
  };

  xdg.configFile = {
    "zsh".source = link "dot-config/zsh";
    "nvim".source = link "dot-config/nvim";
    "tmux".source = link "dot-config/tmux";
    "yazi".source = link "dot-config/yazi";
    "starship.toml".source = link "dot-config/starship.toml";
  };

  # Translated from ../../package-lists/packages.conf. A few names changed
  # vs. the Debian/apt names there:
  #   node -> nodejs, make -> gnumake,
  #   neofetch -> fastfetch, youtube-dl -> yt-dlp
  # steam, zsh and ufw are handled at system level (see ../modules/).
  home.packages = with pkgs; [
    # CODING
    gcc
    gdb
    git
    gnumake
    go
    lazygit
    neovim
    nodejs
    python3
    ripgrep
    shellcheck

    # FUN
    cmatrix
    cowsay
    fortune

    # PRODUCTIVITY
    pandoc
    syncthing

    # MEDIA
    ffmpeg
    yt-dlp

    # SYSTEM
    bat
    eza
    fd
    fzf
    htop
    fastfetch
    starship
    p7zip
    tmux
    tree
    wget
    yazi
  ];
}
