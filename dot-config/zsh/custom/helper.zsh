# Helper functions for shell setup

# add a path to PATH env var if it doesnt already exist
path_add() {
	[[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}

# check if a program is installed
program_is_installed() {
	command -v "$1" >/dev/null 2>&1
}
