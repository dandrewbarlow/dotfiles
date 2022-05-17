#! /bin/bash
# Andrew Barlow
# A script to run every time the shell starts I know that's what the .zshrc
# file is for, but I want to make a distinction between configuration settings
# and scripting actions

# check for dotfile updates
cd "$HOME/.dotfiles"

# make sure the main branch is active and bring remote refs up to date
git checkout main &> /dev/null
git remote update &> /dev/null

# check for a pullable update
if [ -n "$(git status -s -u no)" ]; then

	# ask if you want to update
	read -r -p "Update dotfile repo? [y/n]" response

	# if yes, then pull the latest updates
	# https://stackoverflow.com/questions/3231804/in-bash-how-to-add-are-you-sure-y-n-to-any-command-or-alias
	case "$response" in 
		[yY][eE][sS]|[yY]) 
			git pull
		;;
	*)
		;;
	esac

fi

cd "$HOME"

# prevents my annoying startup flex in vscode
if [ "$TERM_PROGRAM" != "vscode" ];
then
	neofetch
fi
