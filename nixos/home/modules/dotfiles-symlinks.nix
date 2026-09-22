# Points home-manager at this same repo's existing dot-* directories,
# out-of-store, the same way `stow . --dotfiles` (see ../../../CLAUDE.md)
# would. Nothing is copied into the nix store; these are live symlinks
# back into ~/code/dotfiles, so editing a file there takes effect
# immediately without a rebuild.
#
# Keep this list in sync with the top-level dot-* / dot-config/* entries
# in the repo (add an entry here when you add a new dot-config/<thing>).
{ config, lib, ... }:

let
  dotfiles = "${config.home.homeDirectory}/code/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  home.file = {
    ".zshrc".source = link "dot-zshrc";
    ".scripts".source = link "dot-scripts";
    ".oh-my-zsh".source = link "dot-oh-my-zsh";
  };

  xdg.configFile = {
    "zsh".source = link "dot-config/zsh";
    "nvim".source = link "dot-config/nvim";
    "hypr".source = link "dot-config/hypr";
    "hyprland".source = link "dot-config/hyprland";
    "waybar".source = link "dot-config/waybar";
    "kitty".source = link "dot-config/kitty";
    "tmux".source = link "dot-config/tmux";
    "yazi".source = link "dot-config/yazi";
    "mpv".source = link "dot-config/mpv";
    "rofi".source = link "dot-config/rofi";
    "ghostty".source = link "dot-config/ghostty";
    "kando".source = link "dot-config/kando";
    "herdr".source = link "dot-config/herdr";
    "yay".source = link "dot-config/yay";
    "starship.toml".source = link "dot-config/starship.toml";
  };
}
