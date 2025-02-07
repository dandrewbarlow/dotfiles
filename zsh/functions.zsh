
# Functions ==================================================

# neat little function to extract files from reddit
# https://www.reddit.com/r/bash/comments/g5lkb7/best_function_ever_o/
ex ()
{
	if [ -f "$1" ] ; then
		case "$1" in
			*.tar.bz2)	tar xjf "$1"	;;
			*.tar.ga)	tar xzf "$1"	;;
			*.bz2)		bunzip2 "$1"	;;
			*.rar)		unrar x "$1"	;;
			*.gz)		tar xf "$1"	;;
			*.tar)		tar xf "$1"	;;
			*.tbz2)		tar xjf "$1"	;;
			*tgz)		tar xzf "$1"	;;
			*zip)		unzip "$1"	;;
			*Z)		uncompress "$1"	;;
			*.7z)		7z x "$1"	;;
			*.tar.gz)	tar J "$1"	;;
			*.xz)		tar xvf "$1"	;;
			*)		echo "'$1' cannot be extracted with ex(), unknown file type"	;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# make a directory and enter it
m(){mkdir -p "$1" && cd "$1"}

# temp dir
function cdtmp {
  TMP="$(mktemp -d)"
  cd "$TMP"
}

# Distro specific helper functions

distro="$(cat /etc/os-release | grep '^NAME' | cut -d "=" -f 2 | sed 's/\"//g' )"
if [[ "$distro" == "Arch Linux" ]]; then
  function sin {
    search "$@" | grep '^[[:alpha:]]' | fzf --tac | cut --delimiter " " --fields 1
  }
fi
