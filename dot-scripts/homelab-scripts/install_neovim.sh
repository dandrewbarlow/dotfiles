#! /usr/bin/env bash
#
# install_neovim.sh
#
# An easy way to install/upgrade neovim on distros that are perhaps too stable

set -euo pipefail

install_dir="$HOME/.opt"
symlink_dir="$HOME/.local/bin"
repo="neovim/neovim"

prefix="$install_dir/nvim"        # where the tarball ends up living
bin="$prefix/bin/nvim"
link="$symlink_dir/nvim"

force=0
[[ "${1:-}" == "-f" || "${1:-}" == "--force" ]] && force=1

for cmd in curl jq tar; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "missing dependency: $cmd" >&2; exit 1; }
done

# Neovim names its assets nvim-linux-{x86_64,arm64}.tar.gz, which does not
# quite match what uname reports.
case "$(uname -m)" in
  x86_64 | amd64)  arch="x86_64" ;;
  aarch64 | arm64) arch="arm64"  ;;
  *) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac
asset="nvim-linux-${arch}.tar.gz"

# https://docs.github.com/en/rest/releases/releases#get-the-latest-release
# GITHUB_TOKEN is optional; it just lifts the 60 req/hr unauthenticated limit.
release="$(curl -fsSL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  ${GITHUB_TOKEN:+-H "Authorization: Bearer $GITHUB_TOKEN"} \
  "https://api.github.com/repos/${repo}/releases/latest")"

# Pull the tag and the download URL for our arch out in one pass. jq bails with
# a message on stderr if the release has no asset matching this arch.
IFS=$'\t' read -r tag url < <(
  jq -r --arg name "$asset" '
    ([.assets[] | select(.name == $name)] | first) as $a
    | if $a == null
      then "no asset named \($name) in release \(.tag_name)" | halt_error(1)
      else . end
    | [.tag_name, $a.browser_download_url] | @tsv
  ' <<< "$release"
)

# Compare against the copy we manage, not whatever nvim is on $PATH -- the
# distro package is exactly the stale thing we are working around.
current=""
[[ -x "$bin" ]] && current="$("$bin" --version | head -1 | awk '{print $2}')"

if [[ "$current" == "$tag" && $force -eq 0 ]]; then
  echo "neovim $tag already installed at $prefix (--force to reinstall)"
  exit 0
fi

echo "installing neovim $tag${current:+ (over $current)}"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "downloading $asset..."
curl -fL --progress-bar -o "$tmp/$asset" "$url"
tar -xzf "$tmp/$asset" -C "$tmp"

# The tarball holds a single top-level dir, e.g. nvim-linux-x86_64/
src="$tmp/nvim-linux-${arch}"
[[ -x "$src/bin/nvim" ]] || { echo "unexpected tarball layout: no $src/bin/nvim" >&2; exit 1; }

mkdir -p "$install_dir" "$symlink_dir"

# Swap the new tree in, keeping the old one until the new one is in place so a
# failure here does not leave us with no nvim at all.
if [[ -d "$prefix" ]]; then
  rm -rf "${prefix:?}.old"
  mv "$prefix" "$prefix.old"
fi
if ! mv "$src" "$prefix"; then
  echo "install failed, restoring previous version" >&2
  [[ -d "$prefix.old" ]] && mv "$prefix.old" "$prefix"
  exit 1
fi
rm -rf "${prefix:?}.old"

ln -sfn "$bin" "$link"

echo "installed $("$bin" --version | head -1) -> $prefix"
echo "symlinked $link"

case ":$PATH:" in
  *":$symlink_dir:"*) ;;
  *) echo "note: $symlink_dir is not on your \$PATH" >&2 ;;
esac
