#!/bin/bash

# setup miniconda
url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
target="/home/$USERNAME/Downloads/$(parse_url $url)"
sudo -u $USERNAME mkdir /home/$USERNAME/Downloads

sudo -u $USERNAME curl "$url" --output "$target"
sudo -u $USERNAME bash "$target" -b -p "/home/$USERNAME/miniconda"
sudo -u $USERNAME /home/$USERNAME/miniconda/condabin/conda init
sudo -u $USERNAME /home/$USERNAME/miniconda/condabin/conda create --name py39 -y python=3.9