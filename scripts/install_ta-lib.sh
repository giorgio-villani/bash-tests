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

sudo -u $USERNAME mkdir /home/$USERNAME/Downloads

sudo -u $USERNAME wget "$url" -P "$target_directory"
sudo -u $USERNAME tar -xzf $target --directory /home/$USERNAME/

sudo -u $USERNAME pip3 install --upgrade pip
sudo -u $USERNAME apt-get -y install gcc
sudo -u $USERNAME apt-get install -y make

cd /home/$USERNAME/ta-lib/

sudo -u $USERNAME ./configure --prefix=/usr
sudo -u $USERNAME make
sudo -u $USERNAME make install

cd ~
sudo -u $USERNAME rm -rf ta-lib/
sudo -u $USERNAME pip install ta-lib
