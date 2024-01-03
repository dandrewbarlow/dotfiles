# LOAD EXTERNAL =======================================================
# lets me separate logic

# https://koenwoortman.com/zsh-split-zshrc-into-multiple-files/
# Load seperated config files
for conf in "$HOME/.config/zsh/custom/"*.zsh; do
  source "${conf}"
done
unset conf

# Shell Startup ==================================================
# just gives a lil bit of life to the terminal

# if starship is installed, use that as theme instead of spaceship (faster)
if [ ! -z "$(which starship)" ] 
then
	eval "$(starship init zsh)"
else
	ZSH_THEME="spaceship"
fi

[ -f "$HOME/.scripts/terminal_startup.sh" ] && "$HOME/.scripts/terminal_startup.sh"

