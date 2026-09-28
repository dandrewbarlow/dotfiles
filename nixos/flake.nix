{
  description = "Andrew Barlow's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      # Every host = common base + one profile + its own hosts/<hostname>/
      # dir (hardware config, bootloader, anything machine-specific).
      #   profile: "desktop"  - full KDE Plasma user environment
      #            "headless" - SSH-only dev/hosting box
      mkHost = { hostname, profile, system ? "x86_64-linux" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              networking.hostName = hostname;
            }
            ./modules/common.nix
            ./modules/${profile}.nix
            ./hosts/${hostname}
          ];
        };
    in
    {
      # Generic starting points. For a real machine, copy hosts/desktop or
      # hosts/headless to hosts/<name>/ and add a line here, e.g.
      #   mybox = mkHost { hostname = "mybox"; profile = "headless"; };
      nixosConfigurations = {
        desktop = mkHost { hostname = "desktop"; profile = "desktop"; };
        headless = mkHost { hostname = "headless"; profile = "headless"; };
      };
    };
}
