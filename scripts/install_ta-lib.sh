#!/bin/bash

parse_url() {
    if [ -z $LINODE_ID]; then
        echo "${1##*/}"
    else
        echo "${1##*/}"
    fi
}

url="http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz"
target_directory="/home/$USERNAME/Downloads"
target="$target_directory/$(parse_url $url)"

echo $url
echo $target_directory
echo $target

mkdir /home/$USERNAME/Downloads

wget "$url" -P "$target_directory"
sudo tar -xzf $target --directory /home/$USERNAME/

# pip3 install --upgrade pip
# sudo apt-get install gcc
# sudo apt-get install -y make

cd /home/$USERNAME/ta-lib/

sudo ./configure --prefix=/usr
sudo make
sudo make install

cd ~
sudo rm -rf ta-lib/
pip install ta-lib
