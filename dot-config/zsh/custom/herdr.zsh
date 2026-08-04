# zsh completions
# herdr: https://herdr.dev/docs/cli-reference/#shell-completions
#
# fpath entries must be DIRECTORIES, and each file inside must be named after
# the function it defines (`_herdr` for the `herdr` command) for compinit to
# autoload it.
#
# This file loads before oh-my-zsh.zsh in glob order, so fpath is populated
# before oh-my-zsh runs compinit -- no second compinit needed here.
# Drop additional `_<command>` files in the dir below to add more completions.

comp_dir="$HOME/.config/zsh/completions"

if [ -d "$comp_dir" ]; then
    fpath=("$comp_dir" $fpath)
fi

unset comp_dir
