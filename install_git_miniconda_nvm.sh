#!/bin/bash

# setup git
sudo -u $USER git config --global user.name "$GITHUB_NAME"
sudo -u $USER git config --global user.email "$GITHUB_EMAIL"
sudo -u $USER git config --global core.editor vim
sudo -u $USER ssh-keygen -t ed25519 -C "$HOSTNAME" -N "" -q -f ~/.ssh/id_ed25519 <<< "y"

# setup miniconda
url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
target="/home/$USER/Downloads/$${url##*/}"
sudo -u $USER mkdir /home/$USER/Downloads

sudo -u $USER curl "$url" --output "$target"
sudo -u $USER bash "$target" -b -p "/home/$USER/miniconda"
sudo -u $USER /home/$USER/miniconda/condabin/conda init
sudo -u $USER /home/$USER/miniconda/condabin/conda create --name py39 -y python=3.9

# setup nvm
url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh"
target="/home/$USER/Downloads/$${url##*/}"

sudo -u $USER curl "$url" --output "$target"
sudo -u $USER bash "$target" -b -p "/home/$USER/nvm/v0.39.2/install.sh"
# sudo -u $USER nvm install 16 && nvm use 16 && npm -g install yarn
