#!/usr/bin/env bash
echo "[ENV_INIT] Setting up environment for ${MSYSTEM}"
CONFIG_DIR="${1:-$(realpath $(dirname "$0")/../.config)}"
SLIM_BUILD=f
shift
# flag parsing
while test $# != 0
do
    case "$1" in
    -s) SLIM_BUILD=t;;
    *)  echo 'unknown parameter: '${1};;
    esac
    shift
done

if [[ ! ${SLIM_BUILD} = t ]]; then
    echo "<< [ENV_INIT] ENVIRONMENT>>"
else
    echo "<< [ENV_INIT] SLIM ENVIRONMENT>>"
fi
echo "[ENV_INIT] installing essential tools"
# update essential tools
pacman -Syu git make --noconfirm --needed;

echo "[ENV_INIT] setting up ssh-agent"
# add ssh-agent startup to the .bashrc
if ! grep -m 1 -Fq '#startup of ssh-agent' ~/.bashrc ; then
    echo  >> ~/.bashrc
    echo '#startup of ssh-agent (https://serverfault.com/a/978680)' >> ~/.bashrc
    echo 'export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock' >> ~/.bashrc
    echo 'ssh-add -l 2>/dev/null >/dev/null' >> ~/.bashrc
    echo '[ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null' >> ~/.bashrc
    echo 'find ~/.ssh/ | grep -v '\.pub' | grep id | xargs ssh-add >/dev/null 2>/dev/null'\
    >> ~/.bashrc
    eval "$(cat ~/.bashrc | tail -n 5)"
fi

# setup The Ultimate vimrc (Basic version)
echo "[ENV_INIT] setting up .vimrc"
mkdir -p ~/.config && cp ${CONFIG_DIR}/.vimrc ~/.config
if ! grep -Fxq '#Ultimate Vimrc' ~/.bashrc ; then
     echo  >> ~/.bashrc
     echo '#Ultimate Vimrc' >> ~/.bashrc
     echo 'alias vim="vim -u ~/.config/.vimrc"' >> ~/.bashrc
fi

# install/update Python
echo "[ENV_INIT] setting up Python..."
pacman -Syu mingw-w64-ucrt-x86_64-python3 --noconfirm --needed

# install/update Godot
echo "[ENV_INIT] setting up Godot..."
pacman -Syu mingw-w64-ucrt-x86_64-godot --noconfirm --needed

if [[ ${SLIM_BUILD} = t ]]; then
    echo '[ENV_INIT] slim build'
else
    echo '[ENV_INIT] installing additional tools'
    # install additional command prompt tools
    pacman -Syu vim tmux tree --noconfirm --needed;
fi
echo "<<< [ENV_INIT] Complete >>>"
