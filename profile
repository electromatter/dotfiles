# Try the distributions profile, if it exists
if [ -e "$HOME/.profile.dist" ]; then
	. "$HOME/.profile.dist"
fi

# Use VIM
VIM=$(which VIM)
if [ -n "$VIM" ]; then
	set -o vi
	VISUAL="$VIM"
	EDITOR="$VIM"
fi
unset VIM

# Add $HOME/.bin to path
if [ -e "$HOME/.bin" ]; then
	PATH="$HOME/.bin:$PATH"
fi

# gnupg ssh agent
SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
export SSH_AUTH_SOCK
