
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

# Find functions: some commands to make finding files less verbose
#
# --- fd with graceful fallback ---------------------------------
# Debian/Ubuntu ship fd as 'fdfind' (name clash), so alias it back.
command -v fdfind >/dev/null 2>&1 && alias fd='fdfind'

# Only define a fallback when neither fd nor fdfind exists.
if ! command -v fd >/dev/null 2>&1 && ! command -v fdfind >/dev/null 2>&1; then
  fd() { find "${2:-.}" -iname "*$1*" 2>/dev/null; }
fi

# --- focused helpers (work everywhere, even busybox) -----------
ff()   { find "${2:-.}" -iname "*$1*"          2>/dev/null; }  # any name match
ffd()  { find "${2:-.}" -type d -iname "*$1*"  2>/dev/null; }  # directories only
fff()  { find "${2:-.}" -type f -iname "*$1*"  2>/dev/null; }  # files only
fe()   { find "${2:-.}" -type f -iname "*.$1"  2>/dev/null; }  # by extension
fnew() { find "${2:-.}" -type f -mtime -"${1:-1}" 2>/dev/null; } # modified in last N days


# Distro specific helper functions

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	distro="$(cat /etc/os-release | grep '^NAME' | cut -d "=" -f 2 | sed 's/\"//g' )"
	if [[ "$distro" == "Arch Linux" ]]; then
	  function sin {
	    search "$@" | grep '^[[:alpha:]]' | fzf --tac | cut --delimiter " " --fields 1
	  }
	fi
fi
