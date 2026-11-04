#! /usr/bin/env bash
# arch linux maintenence script for infrequent commands that I forget

# list of options to feed into fzf, separated by newline char
options="Clean Package Cache\nRemove Orphan Packages\nUpdate Mirrors"

# list options, pipe into fzf, store response in action var
action="$(echo -e "$options" | fzf)"

# Elevate to superuser permissions, runs args as sudo command
get_sudo () {
	if [ "$EUID" -ne 0 ]; then
		sudo "$@"
	else
		"$@"
	fi
}

# get fastest mirrors for repos
update_mirrors () {
	# mirror list location. safe default, but don't like typing allat
	mirrorfile="/etc/pacman.d/mirrorlist"

	# backup old mirror file, only continue if the copy succeeded
	if get_sudo cp -v "$mirrorfile" "$mirrorfile.bk"; then
		# Warning prompt to avoid user accidentally terminating script early
		echo "Fetching fastest mirrors. This may take a minute."

		# run reflector to get fastest mirrors, save to mirrorlist
		get_sudo reflector --country US --protocol https --latest 20 --sort rate --number 10 --save "$mirrorfile"

		yay -Syy
	else
		echo "Error, mirrorfile not backed up. Action aborted."
	fi
}


# case statement matches action var and runs command
case "$action" in
	"Clean Package Cache")
		echo "$action"
		paccache -r
		;;
	"Remove Orphan Packages")
		echo "$action"
		orphans=$(yay -Qdtq) && yay -Rns $orphans
		# yay -Qdtq | yay -Rns -
		;;

	"Update Mirrors")
		echo "$action"
		update_mirrors
		;;
	*)
		echo "No action selected, exiting"
		;;
esac
