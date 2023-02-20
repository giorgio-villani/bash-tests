#!/bin/bash

echo "Running Setup on: " $USERNAME

# setup git
sudo -u $USERNAME git config --global user.name "$GITHUB_NAME"
sudo -u $USERNAME git config --global user.email "$GITHUB_EMAIL"
sudo -u $USERNAME git config --global core.editor vim
sudo -u $USERNAME ssh-keygen -t ed25519 -C "$HOSTNAME" -N "" -q -f /home/$USERNAME/.ssh/id_ed25519 <<< "y"