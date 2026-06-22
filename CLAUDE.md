# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Deploying dotfiles

Symlinks are managed with GNU `stow`. To deploy all dotfiles to `$HOME`:

```sh
stow . --dotfiles
```

The `--dotfiles` flag makes stow treat `dot-` prefixed files/directories as `.`-prefixed targets (e.g. `dot-zshrc` → `~/.zshrc`, `dot-config/` → `~/.config/`).

Files listed in `.stow-local-ignore` are excluded: `.git`, `.gitignore`, `.gitmodules`, `README.md`, and `package-lists/`.

## Repository structure

| Path | Stow target | Purpose |
|------|-------------|---------|
| `dot-zshrc` | `~/.zshrc` | Zsh entry point — sources all files in `~/.config/zsh/custom/*.zsh` |
| `dot-config/zsh/custom/` | `~/.config/zsh/custom/` | Modular zsh config (env, aliases, functions, fzf-tab, oh-my-zsh) |
| `dot-config/nvim/` | `~/.config/nvim/` | Neovim config — **git submodule** pointing to a separate repo |
| `dot-oh-my-zsh/` | `~/.oh-my-zsh/` | Oh-My-Zsh customizations; zsh plugins are git submodules |
| `dot-scripts/` | `~/.scripts/` | Personal shell scripts added to `$PATH` |
| `dot-config/hypr/` | `~/.config/hypr/` | Hyprland compositor config |
| `dot-config/waybar/` | `~/.config/waybar/` | Status bar (config + CSS) |
| `dot-config/kitty/` | `~/.config/kitty/` | Kitty terminal emulator |
| `dot-config/tmux/` | `~/.config/tmux/` | Tmux config |
| `dot-config/yazi/` | `~/.config/yazi/` | File manager (yazi); flavors are a git submodule |
| `dot-config/mpv/` | `~/.config/mpv/` | MPV media player config + scripts/shaders |
| `package-lists/` | (not stowed) | Reference lists of packages, flatpaks, and VS Code extensions |

## Git submodules

```sh
git submodule update --init --recursive
```

Submodules:
- `dot-config/nvim` — Neovim config (separate repo)
- `dot-oh-my-zsh/custom/plugins/zsh-autosuggestions`
- `dot-oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
- `dot-oh-my-zsh/custom/plugins/fzf-tab`
- `dot-oh-my-zsh/custom/plugins/fzf-zsh-plugin`
- `dot-config/yazi/flavors`

## Zsh config loading order

`dot-zshrc` sources `~/.config/zsh/custom/*.zsh` in glob order, then runs starship (or falls back to the spaceship theme). The custom files load in this effective order:

1. `env.zsh` — PATH additions, tool env vars (EDITOR, MANPAGER, etc.), secrets from `~/.env`
2. `functions.zsh` — shell functions
3. `fzf-tab.zsh` — fzf-tab plugin config (must load before oh-my-zsh)
4. `helper.zsh` — `program_is_installed()` and `path_add()` utilities used by the other files
5. `oh-my-zsh.zsh` — plugin list + `source $ZSH/oh-my-zsh.sh`; fzf key bindings sourced after so they aren't overwritten by oh-my-zsh
6. `z-aliases.zsh` — all aliases (named with `z-` prefix to load last)

## Key conventions

- Aliases are conditional on program availability via `program_is_installed` from `helper.zsh`.
- Package manager aliases (`install`, `search`, `update`) are set dynamically based on distro detection at shell startup.
- `podman` is aliased to `docker` when installed; `$DOCKER_HOST` is set to the podman socket.
- Secrets live in `~/.env` (not tracked); `env.zsh` sources it with `set -a / set +a` to export all vars.
