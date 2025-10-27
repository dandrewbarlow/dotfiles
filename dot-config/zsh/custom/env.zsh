
# ENVIRONMENT VARIABLES ==================================================

# custom scripts
export PATH="$HOME/.scripts:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt:$PATH"

# docker -> podman
if command -v podman >/dev/null 2>&1; then
  export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"
fi

export VDPAU_DRIVER='nvidia'

# man pages in bat
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Doom emacs path
export PATH="$HOME/.emacs.d/bin:$PATH"

# Dumb CUDA stuff
export PATH="$PATH:/opt/cuda/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64"

# npm global path
export PATH="$HOME/.npm-global/bin:$PATH"

# rust path
export PATH="$HOME/.cargo/bin/:$PATH"

# Spicetify- spotify customization
export SPICETIFY_INSTALL="$HOME/.spicetify-cli"
export PATH="$SPICETIFY_INSTALL:$PATH"

# Processing path 
export PATH="$PATH:/opt/processing"

export PATH="$PATH:$HOME/.local/bin"

# Go binaries
export PATH="$PATH:$HOME/go/bin"
# CUDA compiler
CYCLES_CUDA_EXTRA_CFLAGS="-ccbin /usr/local/gcc-10.3.0/bin/gcc"

export COWPATH="$COWPATH:$HOME/.dotfiles/cowsay-files/cows"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

if command -v nvim >/dev/null 2>&1; then
  export EDITOR='nvim'
fi

export DOOMDIR="$HOME/.config/doom/"

export PATH="$HOME/.rbenv/bin:$PATH"
[ ! "$(type rbenv)" = "rbenv not found" ] && eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# for secrets, shhh
if [ -e "$HOME/.env" ]; then
  set -a
  . "$HOME/.env"
  set +a
fi

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/andrew/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/andrew/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh

# export LESS_TERMCAP_mb=$'\e[1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'


# Colors ==================================================
# Just an attempt to make shell a little more fun sometimes
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

# No Color
NC='\033[0m' 

BLACK='\033[0;30m'
DARKGRAY='\033[1;30m'
RED='\033[0;31m'
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
BROWN='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHTBLUE='\033[1;34m'
PURPLE='\033[0;35m'
LIGHTPURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHTCYAN='\033[1;36m'
LIGHTGRAY='\033[0;37m'
WHITE='\033[1;37m'

