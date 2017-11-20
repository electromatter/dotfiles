# Try the distributions profile, if it exists
if [ -e "$HOME/.profile.dist" ]; then
	source "$HOME/.profile.dist"
fi

# Use VIM
set -o vi
VISUAL="/usr/bin/vim"
EDITOR="/usr/bin/vim"

# Add $HOME/.bin to path
PATH="$HOME/.bin:$PATH"

# gnupg ssh agent
SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
export SSH_AUTH_SOCK
