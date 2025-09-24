#! /usr/bin/env bash

options="Clean Package Cache\nRemove Orphan Packages"

action="$(echo -e "$options" | fzf)"


case "$action" in
	"Clean Package Cache")
	    echo "$action"
	    paccache -r
		;;
	"Remove Orphan Packages")
	    echo "$action"
	    yay -Qdtq | yay -Rns -
		;;
	*)
		;;
esac
