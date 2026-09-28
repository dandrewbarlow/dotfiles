# nixos/

NixOS + home-manager flake. `dot-config/`, `dot-scripts/`, etc. are not
duplicated here — home-manager symlinks them out-of-store from
`~/.dotfiles`, so the repo must be cloned there.

## Layout

| Path | Purpose |
|------|---------|
| `flake.nix` | `mkHost { hostname, profile }` + the list of hosts |
| `modules/common.nix` | System config every host gets (user, zsh, locale, nix settings, firewall) |
| `modules/desktop.nix` | Profile: KDE Plasma 6 (SDDM), pipewire, steam, GUI home config |
| `modules/headless.nix` | Profile: SSH-only dev/hosting box (openssh, podman) |
| `home/common.nix` | home-manager for every profile: CLI packages, shell/terminal dotfiles |
| `home/desktop.nix` | home-manager additions for the desktop profile: GUI apps + their dotfiles |
| `hosts/<name>/` | Per-machine: `hardware-configuration.nix`, bootloader, `stateVersion` |

`desktop` and `headless` are generic starting-point hosts. Their
`hardware-configuration.nix` files are **stubs** so the flake evaluates.

## Adding a machine

1. `cp -r hosts/headless hosts/<name>` (or `hosts/desktop`)
2. Add `<name> = mkHost { hostname = "<name>"; profile = "headless"; };`
   to `nixosConfigurations` in `flake.nix`
3. Replace `hosts/<name>/hardware-configuration.nix` with the output of
   `nixos-generate-config --show-hardware-config` on that machine
4. `git add` it — flakes ignore untracked files

## Testing

- Eval check: `nix flake check`
- Build without applying: `nixos-rebuild build --flake .#<name>`
- Disposable VM: `nixos-rebuild build-vm --flake .#<name>`
- Apply: `sudo nixos-rebuild switch --flake .#<name>`
