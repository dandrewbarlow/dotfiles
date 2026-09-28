# Profile: headless dev/hosting box. No GUI; reached over SSH.
{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true; # also opens port 22 in the firewall
    settings.PermitRootLogin = "no";
  };

  # Containers for hosting; env.zsh already points $DOCKER_HOST at the
  # podman socket.
  virtualisation.podman.enable = true;
}
