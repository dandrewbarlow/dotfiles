{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/dotfiles-symlinks.nix
  ];

  home.username = "andrew";
  home.homeDirectory = "/home/andrew";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
