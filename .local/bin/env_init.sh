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

echo "[ENV_INIT] setting up ssh agent and ssh config"
# add ssh-agent startup to the .bashrc
if ! grep -m 1 -Fq '#startup of ssh-agent' ~/.profile; then
    echo  >> ~/.profile
    echo '#startup of ssh-agent (https://serverfault.com/a/978680)' >> ~/.profile
    echo 'export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock' >> ~/.profile
    echo 'ssh-add -l 2>/dev/null >/dev/null' >> ~/.profile
    echo '[ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null' >> ~/.profile
    echo 'find ~/.ssh/ | grep -v '\.pub' | grep id | xargs ssh-add >/dev/null 2>/dev/null'\
    >> ~/.profile
    eval "$(cat ~/.profile | tail -n 5)"
    # add the key to ssh config
    touch ~/.ssh/config
    if ! grep -m 1 -Fq "#github profile $(git config --global user.name)" ~/.ssh/config; then
        username=$(git config --global user.name)
        echo  >> ~/.ssh/config
        echo "#github profile ${username}" >> ~/.ssh/config
        echo "Host github.com" >> ~/.ssh/config
        echo "    HostName github.com" >> ~/.ssh/config
        echo "    PreferredAuthentications publickey" >> ~/.ssh/config
        echo "    IdentityFile ~/.ssh/id_ed25519-${username}" >> ~/.ssh/config
    fi
fi

# setup The Ultimate vimrc (Basic version)
echo "[ENV_INIT] setting up .vimrc"
mkdir -p ~/.config && cp ${CONFIG_DIR}/.vimrc ~/.config
if ! grep -Fxq '#Ultimate Vimrc' ~/.bashrc ; then
     echo  >> ~/.bashrc
     echo '#Ultimate Vimrc' >> ~/.bashrc
     echo 'alias vim="vim -u ~/.config/.vimrc"' >> ~/.bashrc
fi

# ask if they want to continue with installation
read -p "Install packages? (Can take 20-30 minutes) Y/N: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "[ENV_INIT] ending without installing packages"
    return 1
fi

echo "[ENV_INIT] installing essential tools"
# update essential tools
pacman -Syu git make --noconfirm --needed;

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
