# Linux-Essentials
### Andrew Barlow
A repo to help quickly setup a customized dev environment

## Guide
These scripts are for setting up a linux environment quickly. I have not had the chance to test them out yet, so take them with a grain of salt. That said I tried to make them usable for fedora, ubuntu, and arch. `install-script.sh` was designed to be the script to rule them all, calling other scripts for some possible modularity. That said they can also be called individually. This changes the shell to zsh and uses oh-my-zsh so you will have to log out and back in after finishing, but I would advise a full reboot in case there are kernel updates or anything weird.

## Files
* `install-script.sh`- Calls all the scripts, downloads packages based on distro, contains [oh-my-zsh's one liner](https://github.com/ohmyzsh/ohmyzsh) to install. oh-my-zsh will take over the shell and has to be exited to finish the script. On top of that changing the shell requires a log out and back in after running.
* `my-packages.txt`- Contains a list of packages to be installed
* `git-config.sh`- set the global git username & email settings, using user input
* `atom-install.sh`- Installs atom, also based on distro using [the instructions provided by Atom](https://flight-manual.atom.io/getting-started/sections/installing-atom/). Also installs my atom packages.
* `atom-packages.txt`- contains a list of my atom packages to install
* `mac-fonts.sh`- instructions to download OSX fonts from the [SFWIN Repository](https://github.com/blaisck/sfwin), move them to the fonts directory, and refresh the font cache. Using them still requires them to be manually set, but this at least removes the grunt work of downloading
* `spaceship-theme.sh`- install [spaceship prompt](https://github.com/denysdovhan/spaceship-prompt) (my preferred terminal theme)
