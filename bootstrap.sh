#!/usr/bin/env bash
#
# bootstrap.sh — set up a new machine from this dotfiles repo.
#
# Idempotent and safe to re-run; prompts before each section so you can
# skip parts. Supports Arch (pacman/yay) and Debian/Ubuntu (apt).
#
# Usage:
#   Local (inside the cloned repo):
#     ./bootstrap.sh           # interactive, prompt per section
#     ./bootstrap.sh --yes     # answer yes to every section
#     ./bootstrap.sh --help
#
#   Fresh machine, straight from GitHub:
#     bash <(curl -fsSL https://raw.githubusercontent.com/dandrewbarlow/dotfiles/main/bootstrap.sh)
#     curl -fsSL https://raw.githubusercontent.com/dandrewbarlow/dotfiles/main/bootstrap.sh | bash
#
#   When run with no local repo present, the script clones into ~/.dotfiles
#   (override with DOTFILES_DIR) and re-runs itself from there.
#
set -euo pipefail

# Repo coordinates (override via env when testing forks/branches).
REPO_URL="${DOTFILES_REPO:-https://github.com/dandrewbarlow/dotfiles}"
REPO_BRANCH="${DOTFILES_BRANCH:-main}"
DEST="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Directory this script lives in — may NOT be the repo when curl-piped.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"

ASSUME_YES=0
for arg in "$@"; do
	case "$arg" in
	-y | --yes) ASSUME_YES=1 ;;
	-h | --help)
		grep '^#' "$0" | sed 's/^# \{0,1\}//;1d' | sed '/^!/d'
		exit 0
		;;
	*)
		echo "Unknown argument: $arg" >&2
		exit 1
		;;
	esac
done

# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------
c_blue='\033[1;34m'; c_green='\033[1;32m'; c_yellow='\033[1;33m'; c_reset='\033[0m'
info() { printf "${c_blue}::${c_reset} %s\n" "$*"; }
ok()   { printf "${c_green}✓${c_reset} %s\n" "$*"; }
warn() { printf "${c_yellow}!${c_reset} %s\n" "$*" >&2; }

confirm() {
	[ "$ASSUME_YES" = 1 ] && return 0
	local ans
	printf "${c_blue}?${c_reset} %s [y/N] " "$1"
	# Read from the terminal directly so prompts work even when the script
	# itself arrives on stdin (curl ... | bash).
	if [ -r /dev/tty ]; then read -r ans </dev/tty; else read -r ans; fi
	[[ "$ans" =~ ^[Yy]$ ]]
}

# Sections to run, chosen upfront in plan() and consulted by each section.
declare -A RUN
should_run() { [ "${RUN[$1]:-0}" = 1 ]; }

# ---------------------------------------------------------------------------
# Distro detection
# ---------------------------------------------------------------------------
detect_distro() {
	[ -r /etc/os-release ] || { warn "No /etc/os-release; cannot detect distro"; exit 1; }
	# shellcheck disable=SC1091
	. /etc/os-release
	case " $ID ${ID_LIKE:-} " in
	*" arch "*)             DISTRO=arch ;;
	*" debian "* | *" ubuntu "*) DISTRO=debian ;;
	*)
		warn "Unsupported distro: $ID (ID_LIKE=${ID_LIKE:-none})"
		exit 1
		;;
	esac
	info "Detected distro: $DISTRO"
}

ensure_git() {
	command -v git >/dev/null 2>&1 && return 0
	info "Installing git..."
	case "$DISTRO" in
	arch)   sudo pacman -Sy --needed --noconfirm git ;;
	debian) sudo apt-get update && sudo apt-get install -y git ;;
	esac
}

# When run via `curl | bash` there is no repo on disk yet. Clone it (with
# submodules) into $DEST, then re-exec the local copy so the rest of the
# script operates on real files. When already inside the repo, just cd in.
ensure_local_repo() {
	if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/package-lists/packages.conf" ]; then
		cd "$SCRIPT_DIR"
		return 0
	fi

	info "No local repo detected — bootstrapping from $REPO_URL"
	detect_distro
	ensure_git

	if [ -d "$DEST/.git" ]; then
		info "Existing clone at $DEST; updating"
		git -C "$DEST" pull --ff-only || warn "Could not update $DEST; using as-is"
		git -C "$DEST" submodule update --init --recursive || true
	else
		info "Cloning into $DEST"
		git clone --recurse-submodules --branch "$REPO_BRANCH" "$REPO_URL" "$DEST"
	fi

	info "Re-running from $DEST/bootstrap.sh"
	exec bash "$DEST/bootstrap.sh" "$@"
}

# ---------------------------------------------------------------------------
# Package name maps  (generic name -> distro name; empty value = skip)
#
# Only names that differ from packages.conf need an entry. An empty value
# means "not available from the system package manager here" — handle it via
# flatpak/AUR or skip it (a warning is printed).
# ---------------------------------------------------------------------------
declare -A ARCH_MAP=(
	[python3]=python
)

declare -A DEBIAN_MAP=(
	[python3]=python3
	[fd]=fd-find          # binary is `fdfind`
	[youtube-dl]=yt-dlp   # youtube-dl is effectively dead
	[neofetch]=fastfetch  # neofetch is unmaintained / dropped
	# Not in apt — install via flatpak instead:
	[eza]=""
	[spotify]=""
	[steam]=""
	[dolphin]=""
	[yazi]=""
)

resolve_pkg() {
	local pkg="$1"
	case "$DISTRO" in
	arch)   printf '%s' "${ARCH_MAP[$pkg]-$pkg}" ;;
	debian) printf '%s' "${DEBIAN_MAP[$pkg]-$pkg}" ;;
	esac
}

# ---------------------------------------------------------------------------
# Package-manager abstraction
# ---------------------------------------------------------------------------
pkg_install() {
	# $@ = resolved package names
	[ "$#" -eq 0 ] && return 0
	case "$DISTRO" in
	arch)
		if command -v yay >/dev/null 2>&1; then
			yay -S --needed --noconfirm "$@"
		else
			sudo pacman -S --needed --noconfirm "$@"
		fi
		;;
	debian)
		sudo apt-get install -y "$@"
		;;
	esac
}

# ===========================================================================
# Sections
# ===========================================================================

section_prereqs() {
	case "$DISTRO" in
	arch)   sudo pacman -Sy --needed --noconfirm git stow ;;
	debian) sudo apt-get update && sudo apt-get install -y git stow ;;
	esac
	ok "Prerequisites installed"
}

section_submodules() {
	git submodule update --init --recursive
	ok "Submodules ready"
}

section_omz() {
	# The repo only stows ~/.oh-my-zsh/custom; the oh-my-zsh framework itself
	# must exist for .zshrc to work. Install it BEFORE stow, otherwise stow
	# folds ~/.oh-my-zsh into a symlink and the OMZ installer refuses to run.
	if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
		info "oh-my-zsh already installed"
		return 0
	fi
	# Installer requires zsh + git; curl fetches it.
	pkg_install zsh git curl
	info "Installing oh-my-zsh (unattended)..."
	# RUNZSH=no  : don't drop into zsh when done
	# CHSH=no    : don't change the login shell (avoids an interactive prompt)
	# KEEP_ZSHRC : don't touch ~/.zshrc — we stow our own
	RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	ok "oh-my-zsh installed (set zsh as default shell with: chsh -s \"\$(command -v zsh)\")"
}

section_stow() {
	stow . --dotfiles
	ok "Dotfiles stowed"
}

section_packages() {
	local conf="package-lists/packages.conf"
	[ -r "$conf" ] || { warn "$conf not found; skipping packages"; return; }

	# shellcheck disable=SC1090
	source "$conf"
	# Categories defined as bash arrays in packages.conf:
	local categories=(CODING FUN THEMING PRODUCTIVITY GAMING INTERNET MEDIA SYSTEM)

	local resolved=() skipped=()
	local cat names name r
	for cat in "${categories[@]}"; do
		declare -n names="$cat" 2>/dev/null || continue
		for name in "${names[@]}"; do
			r="$(resolve_pkg "$name")"
			if [ -z "$r" ]; then
				skipped+=("$name")
			else
				resolved+=("$r")
			fi
		done
	done

	if [ "${#skipped[@]}" -gt 0 ]; then
		warn "Not available via $DISTRO package manager (install via flatpak/AUR): ${skipped[*]}"
	fi
	info "Installing ${#resolved[@]} packages..."
	pkg_install "${resolved[@]}"
	ok "Packages installed"
}

section_flatpak() {
	local list="package-lists/flatpak.txt"
	[ -r "$list" ] || { warn "$list not found; skipping flatpak"; return; }
	command -v flatpak >/dev/null 2>&1 || { warn "flatpak not installed; skipping"; return; }

	flatpak remote-add --if-not-exists flathub \
		https://dl.flathub.org/repo/flathub.flatpakrepo || true

	# Column 2 of the saved `flatpak list` output is the application ID.
	local ids
	mapfile -t ids < <(cut -f2 "$list" | grep -v '^$')
	info "Installing ${#ids[@]} flatpaks..."
	flatpak install -y --noninteractive flathub "${ids[@]}" || \
		warn "Some flatpaks failed (may live on a non-flathub remote)"
	ok "Flatpaks done"
}

section_vscode() {
	local list="package-lists/vscode-extensions.txt"
	[ -r "$list" ] || { warn "$list not found; skipping vscode"; return; }
	local code_bin=""
	for b in code code-insiders codium; do
		command -v "$b" >/dev/null 2>&1 && { code_bin="$b"; break; }
	done
	[ -n "$code_bin" ] || { warn "No VS Code binary found; skipping extensions"; return; }

	local ext
	while IFS= read -r ext; do
		[ -z "$ext" ] && continue
		"$code_bin" --install-extension "$ext" --force || warn "Failed: $ext"
	done <"$list"
	ok "VS Code extensions done"
}

# ===========================================================================

# Ordered list of sections: "key|function|description"
SECTIONS=(
	"prereqs|section_prereqs|Install prerequisites (git, stow)"
	"submodules|section_submodules|Init/update git submodules (nvim, zsh plugins, yazi flavors)"
	"omz|section_omz|Install oh-my-zsh framework (required for your zsh config)"
	"stow|section_stow|Symlink dotfiles with stow"
	"packages|section_packages|Install system packages from packages.conf"
	"flatpak|section_flatpak|Install flatpaks from flatpak.txt"
	"vscode|section_vscode|Install VS Code extensions"
)

# Ask upfront which sections to run, so the whole run is unattended afterwards.
plan() {
	info "Choose which sections to run:"
	local entry key desc
	for entry in "${SECTIONS[@]}"; do
		IFS='|' read -r key _ desc <<<"$entry"
		if confirm "  $desc?"; then RUN[$key]=1; else RUN[$key]=0; fi
	done

	local chosen=()
	for entry in "${SECTIONS[@]}"; do
		IFS='|' read -r key _ _ <<<"$entry"
		should_run "$key" && chosen+=("$key")
	done
	if [ "${#chosen[@]}" -eq 0 ]; then
		info "Nothing selected; exiting."
		exit 0
	fi
	info "Will run: ${chosen[*]}"
}

main() {
	ensure_local_repo "$@"
	detect_distro
	plan
	local entry key fn desc
	for entry in "${SECTIONS[@]}"; do
		IFS='|' read -r key fn desc <<<"$entry"
		should_run "$key" || continue
		info "$desc"
		"$fn"
	done
	ok "Bootstrap complete."
}

main "$@"
