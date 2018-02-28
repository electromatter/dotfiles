# Try the distributions profile, if it exists
if [ -e "$HOME/.bashrc.dist" ]; then
	. "$HOME/.bashrc.dist"
fi

# Use VIM
VIM=$(which vim)
if [ -n "$VIM" ]; then
	set -o vi
	VISUAL="$VIM"
	EDITOR="$VIM"
	export VISUAL
	export EDITOR
fi
unset VIM

alias ls="ls --color=auto"
alias grep="grep --color=auto"

# Add $HOME/.bin to path
if [ -e "$HOME/.bin" ]; then
	PATH="$HOME/.bin:$PATH"
fi

# gnupg ssh agent
if [ -z "$SSH_AUTH_SOCK" ]; then
	SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
	export SSH_AUTH_SOCK
fi
