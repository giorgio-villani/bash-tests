#!/bin/bash

# setup nvm
url="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh"
target="/home/$USERNAME/Downloads/$(parse_url $url)"

sudo -u $USERNAME curl "$url" --output "$target"
sudo -u $USERNAME bash "$target" -b -p "/home/$USERNAME/nvm/v0.39.2/install.sh"
# sudo -u $USERNAME nvm install 16 && nvm use 16 && npm -g install yarn
