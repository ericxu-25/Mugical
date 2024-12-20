#!/usr/bin/env bash
echo "Setting up environment for ${MSYSTEM}"
CONFIG_DIR="${1:-$(realpath $(dirname "$0")/../.config)}"
echo "setting up ssh-agent"
# add ssh-agent startup to the .bashrc
if ! grep -Fxq 'eval "$(ssh-agent -s)"' ~/.bashrc ; then
     echo  >> ~/.bashrc
     echo '#startup of ssh-agent' >> ~/.bashrc
     echo  'eval "$(ssh-agent -s)"' >> ~/.bashrc
     echo 'find ~/.ssh/ | grep -v '\.pub' | grep id | xargs ssh-add' >> ~/.bashrc
fi
# install starship (cross-shell prompt)
echo "setting up starship"
pacman -Sy mingw-w64-ucrt-x86_64-starship --noconfirm
pacman -S mingw-w64-ucrt-x86_64-ttf-font-nerd --noconfirm
mkdir -p ~/.config && cp ${CONFIG_DIR}/starship.toml ~/.config
# add starship init to the .bashrc
if ! grep -Fxq 'eval "$(starship init bash)"' ~/.bashrc ; then
	echo >> ~/.bashrc
	echo '#Starship Initializer' >> ~/.bashrc
	echo 'eval "$(starship init bash)"' >> ~/.bashrc
	echo 'export STARSHIP_CONFIG=~/.config/starship.toml' >> ~/.bashrc
fi
# install The Ultimate vimrc (Basic version)
echo "setting up .vimrc"
mkdir -p ~/.config && cp ${CONFIG_DIR}/.vimrc ~/.config
if ! grep -Fxq '#Ultimate Vimrc' ~/.bashrc ; then
     echo  >> ~/.bashrc
     echo '#Ultimate Vimrc' >> ~/.bashrc
     echo 'alias vim="vim -u ~/.config/.vimrc"' >> ~/.bashrc
fi
source ~/.bashrc
#
# install/update relevant software (godot, python, pygame)
#

# install/update Python
echo "setting up python..."

