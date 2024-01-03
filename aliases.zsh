
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

# emacs shortcuts
alias emacs="emacsclient -c -a 'emacs'"
alias e="emacsclient -c -a 'emacs'"

# annoying to type out
alias sys='systemctl'

alias ghci='stack ghci'
alias ghc='stack ghc'

alias popular="history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl |  head -n10"

alias coding="cd $HOME/Dropbox/coding/"

alias c='code'

alias htop='sudo htop'

alias py='python3'

alias z='zathura'

# edit todo file
alias todo="nvim $HOME/TODO.md"

# list sizes of files in pwd, human readable, in ascending order
alias lss='du -sh -- */ | sort -h'

# alternative move command that shows progress
# useful for large files being moved between file systems
# unuseful for renames/moving within the same file system 
# bc it operates like a copy command, just destroys original
alias pmv='rsync --info=progress2 --remove-source-files -a'

# necessary for kitty to properly ssh
# alias ssh="kitty +kitten ssh"

# Conda shortcuts for ease of use
alias ca='conda activate'
alias cl='conda env list'
alias cde='conda deactivate'
alias condapip="$HOME/$CONDA_PREFIX/$CONDA_DEFAULT_ENV/bin/pip"

# Pure Data
alias pd='/usr/local/lib/pd-0.51-3/bin/pd-gui'

# common command in AI art scripts
alias pygen='python3 generate.py'

# cool ones from reddit, haha
# https://old.reddit.com/r/linuxquestions/comments/13c6r2j/favorite_aliases/

# show newest files
alias new="/usr/bin/ls -lth | head -15"

# stop music from playing
alias shh="pkill mpv; pkill mpv"
# play drum&bass internet radio
alias dnb="shh; mpv --really-quiet https://dnbradio.com/hi.pls &"

alias radio="$HOME/scripts/radio/radio.py"

# refresh terminal
alias re="source $HOME/.zshrc"

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
  elif [[ "$distro" == "SteamOS" ]]; then
    alias install='brew install'
    alias search='brew search'
    alias update='brew update && brew upgrade && flatpak update'
    alias flatinst='flatpak install'
    alias flatsearch='flatpak search'
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

