#! /usr/bin/env bash

yay -Ss $1 | awk '{if (/Installed/ && NR%2==1) {print $1, $2, "(installed)"} else if (NR%2==1){print $1, $2}}' \
    | fzf | awk '{print $1}' | yay -S -
