# nixos/

WIP NixOS + home-manager config for host `devarr`, developed inside the
existing dotfiles repo. `dot-config/`, `dot-scripts/`, etc. are unaffected
and still deployed the old way (`stow . --dotfiles`) until this is ready —
see `home/modules/dotfiles-symlinks.nix` for how this flake reuses those
same files rather than duplicating them.

## Status

Nothing here has been applied anywhere. `nix` isn't even installed on the
current Debian machine, so this hasn't been built or evaluated yet —
treat it as unverified until you run `nix flake check`.

`hosts/devarr/hardware-configuration.nix` is a placeholder. It must be
replaced with the real output of `nixos-generate-config` before this
config is ever installed/switched to.

## Trying it out without touching your current setup

- Syntax/eval check only: `nix flake check` (from inside `nixos/`)
- Build without applying anything: `nixos-rebuild build --flake .#devarr`
- Try it in a disposable VM: `nixos-rebuild build-vm --flake .#devarr`
  then run the resulting `./result/bin/run-*-vm`
- Actually switching your running system: `nixos-rebuild switch --flake .#devarr`
  — don't run this until the config is finished and reviewed; it's the
  only command in this list that changes anything live.

None of the above can be run on this machine yet since it's Debian, not
NixOS, and doesn't have `nix` installed. Testing realistically means a
NixOS VM/live-USB first.
