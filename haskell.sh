# Download & run the Haskell script for ur distro

# get distro
distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

if [ $distro = 'fedora' ]
then
	sudo dnf -y install haskell-platform
elif [ $distro = 'ubuntu' ] || [ $distro = 'debian' ]
then
	sudo apt-get -y install haskell-platform
elif [ $distro = 'arch' ] || [ $distro = 'manjaro' ]
then
	sudo pacman --noconfirm -S ghc cabal-install stack
fi

# Set ghci prompt to a pretty lambda
echo ":set prompt \"λ: \"" > ~/.ghc/ghci.conf
