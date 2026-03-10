
# load helper file
source "$HOME/.config/zsh/custom/helper.zsh"
# functions:
# program_is_installed() - check if program is installed
# path_add() - add new path if not exists

# PATH VARIABLES ==================================================

# custom scripts
path_add "$HOME/.scripts"

# If you come from bash you might have to change your $PATH.
path_add "/usr/local/sbin"
path_add "$HOME/.local/bin"
path_add "/opt"

# Doom emacs path
path_add "$HOME/.emacs.d/bin"

# npm global path
path_add "$HOME/.npm-global/bin"

# rust path
path_add "$HOME/.cargo/bin/"

# Processing path 
path_add "/opt/processing"


# Go binaries
path_add "$HOME/go/bin"

# Ruby
path_add "$HOME/.rbenv/bin"
[ ! "$(type rbenv)" = "rbenv not found" ] && eval "$(rbenv init -)"
path_add "$HOME/.rbenv/plugins/ruby-build/bin"



# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# TOOL VARIABLES ==================================================

if program_is_installed nvim; then
  export EDITOR='nvim'
fi

# docker -> podman
if program_is_installed podman; then
  export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"
fi

# man pages in bat
if program_is_installed bat; then
  export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
fi

# doom emacs
export DOOMDIR="$HOME/.config/doom/"

# NVIDIA + CUDA
export VDPAU_DRIVER='nvidia'
path_add "$PATH:/opt/cuda/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64"
CYCLES_CUDA_EXTRA_CFLAGS="-ccbin /usr/local/gcc-10.3.0/bin/gcc"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# MISC ENV VARIABLES ==================================================

# for secrets, shhh
if [ -e "$HOME/.env" ]; then
  set -a
  . "$HOME/.env"
  set +a
fi
