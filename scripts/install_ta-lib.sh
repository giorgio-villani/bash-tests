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

# sudo -u $USERNAME mkdir /home/$USERNAME/Downloads

sudo -u $USERNAME wget $url -P $target_directory
sudo -u $USERNAME tar -xzf $target --directory /home/$USERNAME/

pip_loc="/home/$USERNAME/miniconda/envs/$PY_ENV/bin/pip3"
ta_lib_directory="/home/$USERNAME/ta-lib/"

sudo -u $USERNAME $pip_loc install --upgrade pip
cd $ta_lib_directory

./configure --prefix=/usr
make
make install

sudo -u $USERNAME $pip_loc install ta-lib
rm -rf $ta_lib_directory
cd ~