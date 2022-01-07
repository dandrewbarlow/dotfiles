#! /bin/bash

# git pull "$HOME/.scripts/gitignore/" || notify-send ["gitignore script"] "gitignore repo failed to update"

file="$(ls "$HOME/.scripts/gitignore/" | rofi -dmenu -i -p "Choose gitignore to copy to pwd" | awk '{printf"/home/andrew/.scripts/gitignore/%s", $1}')"

cp "$file" "$(pwd)"