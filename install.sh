#!/bin/sh

# confirm prompt
#     Ask the user "$prompt". If the user responds with
#     Y|y|Yes|yes|YES then return success, failure for anything else.
# confirm prompt default
#     Same as above, but with specified default "Y" or "N"
confirm() {
	read -r -p "$1" YN

	if [ -z "$YN" ]; then
		YN="$2"
	fi

	case "$YN" in
	Y|y|Yes|yes|YES)
		return 0
	;;
	*)
		return 1
	;;
	esac
}

# install_link src
#     links $src to $HOME/.$src
# install_link src dest
#     links $src to $dest
install_link() {
	SOURCE="$(pwd)/$1"
	TARGET="$HOME/.$1"

	if [ -n "$2" ]; then
		# Target was specified, override default
		TARGET="$2"
	fi

	if [ -e "$TARGET" ]; then
		cmp "$SOURCE" "$TARGET" > /dev/null && return 0
		echo "$TARGET exists"
		return 1
	fi

	# Create link
	echo "Linking $TARGET"
	ln -s "$SOURCE" "$TARGET"
}

install_profile() {
	SOURCE="$(pwd)/$1"
	TARGET="$HOME/.$1"

	if [ -n "$2" ]; then
		# Target was specified, override default
		TARGET="$2"
	fi

	if [ -e "$TARGET" ] && cmp "$SOURCE" "$TARGET" > /dev/null; then
		return 0
	elif [ -f "$TARGET" ]; then
		confirm "$TARGET exists. Merge (y/N)? " N || return 1
		mv "$TARGET" "$TARGET.dist"
	elif [ -L "$TARGET" ]; then
		confirm "$TARGET exists and is a link. Override (y/N)? " N || return 1
		rm "$TARGET"
	fi
	install_link "$1" "$TARGET"
}

setup_git() {
	install_link gitignore
	if ! which git > /dev/null; then
		git config --global core.excludesfile "$HOME/.gitignore"
		if [ -n $(git config --get user.name) ]; then
			read -r -p "Git Name: " name
			git config --global user.name "$name"
		fi
		if [ -n $(git config --get user.name) ]; then
			read -r -p "Git Email: " email
			git config --global user.name "$email"
		fi
	fi
}

setup_libinput() {
	install_link inputrc
}

setup_tmux() {
	install_link tmux.conf
}

setup_x11() {
	install_link Xresources
	install_link xmodmap
}

setup_vim() {
	install_link vimrc
	mkdir -p "$HOME/.vim/plugin"
	install_link sensible.vim "$HOME/.vim/plugin/sensible.vim"
}

setup_gpg() {
	[ -e "$HOME/.gnupg/gpg-agent.conf" ] && cmp gpg-agent.conf "$HOME/.gnupg/gpg-agent.conf" && return 0
	confirm "Setup GPG Agent (y/N)? " N || return 0
	mkdir -p "$HOME/.gnupg"
	install_link gpg-agent.conf "$HOME/.gnupg/gpg-agent.conf"
}

setup_bash() {
	install_profile bashrc
}

# Run the setup
setup_git
setup_libinput
setup_tmux
setup_x11
setup_vim
setup_gpg
setup_bash
echo "All Done!"
