#! /bin/bash
# cheat.sh
# written by Andrew Barlow

# DESCRIPTION:
# a script to get and show a cheat sheat on your language of choice. Uses [this
# repo](https://github.com/Randy8080/reference) for content. Customized for my
# dotfiles/dev enviroment. Name taken from [cheat.sh](https://cheat.sh/)
# project bc I'm lazy and will remember that.

if [ "$(which rofi)" -e "" ]; then
	echo "Error: can't find dependency: rofi"
	exit
fi

tmp="$(mktemp)"

# find absolute path of current script
# https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel

SOURCE=${BASH_SOURCE[0]}

while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done

SCRIPT_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )


file="$(ls $SCRIPT_DIR/reference/*.md | xargs basename --suffix=".md" | grep -vi 'README' | rofi -dmenu -p "Pick desired reference")"

# format="echo

success=false

# convert file to pdf, store in temporary file
pandoc "$SCRIPT_DIR/reference/$file.md" --quiet --pdf-engine=xelatex -t pdf > "$tmp" \
	&& success=true

if [ "$success" != true ]; then
	echo "cheat.sh: Error creating PDF"
	rm "$tmp"
	exit 1
fi

# open pdf in default program
xdg-open "$tmp" && echo "PDF Reader Launched"

# find pdf process id
pid="$(ps aux | grep -i "$tmp" | grep -v 'grep' | awk '{print $2}')"

# wait until process finishes
if [ "$pid" != "" ]; then
	while [ -e "/proc/$pid" ]
	do
		sleep .6
	done
	echo "Process Finished"
else
	echo "Error: Process not found"
fi

echo "Removing temporary file"
rm "$tmp"
