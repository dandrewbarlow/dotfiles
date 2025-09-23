#! /usr/bin/env bash

# search.sh
# Andrew Barlow

# Description:
# helper for package managers. mainly so I don't have to search arch repos and
# flatpak seperately. not really a big problem but it's a good exercise.

# I'm using pacman+flatpak, so that's what I'm gonna implement


# keys for case statement in main function; just a string with all the package
# managers I'm using. Logic for new ones is on a strictly DIY basis.
package_managers="pacman flatpak"

paclist=""
paklist=""

# search flathub
function searchFlatpak() {
    paklist="$(flatpak search $1 | tail -n +1 | cut -f1)"

    if [ "$paklist" == "No matches found" ]; then
	paklist=""
    fi
}

# search arch repos & AUR
function searchPacman() {
    paclist="$(yay -Ss $1 | grep '^[a-zA-Z]' | cut -d '/' -f2 | cut -d ' ' -f1)"
}

# run all searches
function searchAll() {
    IFS=' ' read -r -a manager_array <<< "$package_managers"

    for manager in "${manager_array[@]}"; do
	case "$manager" in
		"pacman")
			searchPacman $1
			;;
		"flatpak")
			searchFlatpak $1
			;;
		*)
			echo "Internal Error: invalid package manager"
			;;
	esac
    done
}

# TODO: finish
function installPackage() {

    if [[ $paclist =~ $1 ]]; then
	echo "$1 found in pacman repos"
    fi

}

# main execution loop
function main() {

    searchAll $1

    # TODO: handle mutliple packages
    target_package=$(echo "$paclist" "$paklist" | fzf +m --tac)

    installPackage "$target_package"
}

main $1
