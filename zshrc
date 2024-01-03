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


# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/andrew/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/andrew/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
