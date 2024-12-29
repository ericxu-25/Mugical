#!/usr/bin/env bash
# command to streamline git config and ssh setup
(
     # git config setup
     read -p 'Enter your username for git: ' username;
     git config --global user.name "${username}";
     read -p 'Enter your github email address: ' email_address;
     git config --global user.email "${email_address}";
     # ssh setup
     read -p $'Create an ssh key [Y/N]? (recommended)' -n 1 -r;
     echo ;
     if [[ $REPLY =~  ^[Yy]$ ]]; then
         mkdir -p ~/.ssh;
         read -p $'Enter a password for your ssh key (can leave blank): ' ssh_password;
         ssh-keygen -t ed25519\
         -C "${email_address}"\
         -f ~/.ssh/id_ed25519-"${username}"\
         -N "${ssh_password}"\
         && echo "ssh key created" || { echo 'ssh key creation failed'; exit 1; };
     exit 111;
     fi;
     echo "git setup (without ssh) completed!"
     exit 0;
)
# add the key to the ssh-agent
if [[ $? == 111 ]]; then
    eval "$(ssh-agent -s)";
    ssh-add ~/.ssh/id_ed25519-"$(git config --global user.name)";
    echo "=== Remember to add the public key to your github account! ===";
    echo "Your ssh public key is below:";
    cat ~/.ssh/id_ed25519-"$(git config --global user.name)".pub;
     start \
    'https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?tool=webui';
    start 'https://github.com/settings/keys';
    echo "git setup (with ssh) completed"
    ssh -T git@github.com
fi;
