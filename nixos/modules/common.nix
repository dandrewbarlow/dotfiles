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

  # Kernel console font: used for boot messages and as the fallback if
  # kmscon fails. Bitmap-only, so no nerd font glyphs here.
  console = {
    earlySetup = true;
    packages = [ pkgs.terminus_font ];
    font = "ter-v24n";
  };

  # kmscon replaces the getty login consoles with a userspace terminal that
  # renders real TTF fonts, so starship/yazi glyphs work outside a desktop.
  # With a display manager enabled it leaves tty1 to the display manager.
  services.kmscon = {
    enable = true;
    fonts = [{
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    }];
    extraConfig = "font-size=14";
  };

  # NixOS's built-in firewall replaces ufw from package-lists/packages.conf.
  networking.firewall.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; # needed for spotify, steam, etc.

  environment.systemPackages = with pkgs; [
    git
    vim
  ];
}
