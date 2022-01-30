# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Dumb CUDA stuff
export PATH="$PATH:/usr/local/cuda-11.3/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-11.3/lib64"

# npm global path
export PATH="$HOME/.npm-global/bin:$PATH"

# rust path
export PATH="$HOME/.cargo/bin/:$PATH"

# Spicetify- spotify customization
export SPICETIFY_INSTALL="/home/andrew/.spicetify-cli"
export PATH="$SPICETIFY_INSTALL:$PATH"

# Processing path 
export PATH="$PATH:/opt/processing"

export PATH="$PATH:/home/andrew/.local/bin"

# CUDA compiler
CYCLES_CUDA_EXTRA_CFLAGS="-ccbin /usr/local/gcc-10.3.0/bin/gcc"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

export EDITOR='nvim'

# export LESS_TERMCAP_mb=$'\e[1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	colored-man-pages
	copydir
	copyfile
	cp
	git
	gitignore
	web-search
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/andrew/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/andrew/.anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/andrew/.anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/andrew/.anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Aliases ==================================================
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.


# this one requires some explanation:
# shell only checks the first word for aliases,
# meaning sudo v can't find my vim alias.
# This apparently allows the shell to check the next word
alias sudo='sudo '

# gotta have my neovim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

alias ghci='stack ghci'
alias ghc='stack ghc'

alias popular="history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10"

alias coding="cd $HOME/Dropbox/coding/"

alias c='code'

alias htop='sudo htop'

alias py='python3'

alias z='zathura'

# necessary for kitty to properly ssh
alias ssh="kitty +kitten ssh"

# Conda shortcuts for ease of use
alias ca='conda activate'
alias cl='conda env list'
alias cde='conda deactivate'
alias condapip="$HOME/$CONDA_PREFIX/$CONDA_DEFAULT_ENV/bin/pip"

# Pure Data
alias pd='/usr/local/lib/pd-0.51-3/bin/pd-gui'

# common command in AI art scripts
alias pygen='python3 generate.py'

# OS SPECIFIC
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	
	# open files from command line
	alias open='xdg-open'
	
	# DISTRO SPECIFIC
	distro="$(cat /etc/os-release | grep '^NAME' | cut -d "=" -f 2 | sed 's/\"//g' )"

	if [[ "$distro" == "Fedora Linux" ]]; then
		alias install='sudo dnf install'
		alias search='dnf search'
		alias update='sudo dnf update && flatpak update'
	elif [[ "$distro" == "Arch Linux" ]]; then
		alias install='yay -S'
		alias search='yay -Ss'
		alias update='yay -Syu'
	# have only checked that Ubuntu's output is correct. Easy fix if I ever use 'em
	elif [[ "$distro" == "Ubuntu" ]] || \
	 [[ "$distro" == "Debian" ]] || \
	 [[ "$distro" == "Mint" ]] || \
	 [[ "$distro" == "Pop_OS" ]]; then
		alias install='sudo apt-get install'
		alias update='sudo apt-get update && sudo apt-get upgrade'
	else
		echo "Error detecting distro in .zshrc: ZSH shortcuts may be affected"
	fi
	
elif [[ "$OSTYPE" == "darwin"* ]]; then
	alias install='brew install'
	alias update='brew update && brew upgrade'
fi

# Scripts ===================================================
# Guess I'm a nerd now
alias init="$HOME/.scripts/init.sh"
alias pman="$HOME/.scripts/pman.sh"

alias blender="$HOME/.scripts/start_blender_with_cuda.sh"
alias readpdf="$HOME/.scripts/readpdf.sh"
# ==================================================

# perl stuff? I only vaguely remember what this was for
# syntax is definitely for osx
# I think this was for haskell
PATH="/Users/Andrew/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/Andrew/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/Andrew/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/Andrew/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/Andrew/perl5"; export PERL_MM_OPT;
[ -f "/Users/Andrew/.ghcup/env" ] && source "/Users/Andrew/.ghcup/env" # ghcup-env

# Shell Startup Script ==================================================
# just gives a lil bit of life to the terminal
[ -f "$HOME/.scripts/terminal_startup.sh" ] && "$HOME/.scripts/terminal_startup.sh"
