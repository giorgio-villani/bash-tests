#!/bin/bash

# parse url
parse_url() {
    if [ -z $LINODE_ID]; then
        echo "${1##*/}"
    else
        echo "$${1##*/}"
    fi
}

echo "Running Setup on: " $USERNAME

# setup git
sudo -u $USERNAME git config --global user.name "$GITHUB_NAME"
sudo -u $USERNAME git config --global user.email "$GITHUB_EMAIL"
sudo -u $USERNAME git config --global core.editor vim
sudo -u $USERNAME ssh-keygen -t ed25519 -C "$HOSTNAME" -N "" -q -f /home/$USERNAME/.ssh/id_ed25519 <<< "y"

# setup miniconda
url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
target="/home/$USERNAME/Downloads/$(parse_url $url)"
sudo -u $USERNAME mkdir /home/$USERNAME/Downloads

sudo -u $USERNAME curl "$url" --output "$target"
sudo -u $USERNAME bash "$target" -b -p "/home/$USERNAME/miniconda"
sudo -u $USERNAME /home/$USERNAME/miniconda/condabin/conda init
sudo -u $USERNAME /home/$USERNAME/miniconda/condabin/conda create --name py39 -y python=3.9

# setup nvm
url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh"
target="/home/$USERNAME/Downloads/$(parse_url $url)"

sudo -u $USERNAME curl "$url" --output "$target"
sudo -u $USERNAME bash "$target" -b -p "/home/$USERNAME/nvm/v0.39.2/install.sh"
# sudo -u $USERNAME nvm install 16 && nvm use 16 && npm -g install yarn
