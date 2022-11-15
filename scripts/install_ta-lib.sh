#!/bin/bash

url="http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz"
target="/home/$USERNAME/Downloads/$(parse_url $url)"
sudo -u $USERNAME mkdir /home/$USERNAME/Downloads

sudo -u $USERNAME curl "$url" --output "$target"

sudo tar -xzf $target --directory /home/$USERNAME/
sudo rm $target
cd /home/$USERNAME/ta-lib/

sudo ./configure --prefix=/usr
sudo make
sudo make install
cd ~
sudo rm -rf ta-lib/
pip install ta-lib
