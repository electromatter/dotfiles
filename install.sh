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
	if [ -e "$HOME/.profile" ] && cmp profile "$HOME/.profile" > /dev/null; then
		return 0
	elif [ -f "$HOME/.profile" ]; then
		confirm "$HOME/.profile exists. Merge (Y/n)? " Y || return 1
		mv "$HOME/.profile" "$HOME/.profile.dist"
	elif [ -L "$HOME/.profile" ]; then
		confirm "$HOME/.profile exists and is a link. Override (n/N)? " N || return 1
		rm "$HOME/.profile"
	fi
	install_link profile
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

# Simple files
install_link inputrc
install_link tmux.conf
install_link vimrc
install_link Xresources

# gitconfig
setup_git

# gpg-agent
mkdir -p "$HOME/.gnupg"
install_link gpg-agent.conf "$HOME/.gnupg/gpg-agent.conf"

# profile
install_profile

echo "All done!"