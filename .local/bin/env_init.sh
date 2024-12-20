#!/usr/bin/env bash
echo "Setting up environment for ${MSYSTEM}"
CONFIG_DIR="${1:-$(realpath $(dirname "$0")/../.config)}"
# install starship (cross-shell prompt)
pacman -Sy mingw-w64-ucrt-x86_64-starship --noconfirm
mkdir -p ~/.config && cp ${CONFIG_DIR}/starship.toml ~/.config
if ! grep -Fxq 'eval "$(starship init bash)"' ~/.bashrc ; then
	echo >> ~/.bashrc
	echo '#Starship Initializer' >> ~/.bashrc
	echo 'eval "$(starship init bash)"' >> ~/.bashrc
	echo 'export STARSHIP_CONFIG=~/.config/starship.toml' >> ~/.bashrc
fi
# install The Ultimate vimrc (Basic version)
#
# install/update relevant software (godot, python, pygame)

source ~/.bashrc
