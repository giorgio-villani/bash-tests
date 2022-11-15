#!/bin/bash

# parse url
parse_url() {
    if [ -z $LINODE_ID]; then
        echo "${1##*/}"
    else
        echo "${1##*/}"
    fi
}

url="https://github.com/ethersphere/bee/releases/download/v1.8.2/bee_1.8.2_amd64.deb"
target="/home/$USERNAME/Downloads/$(parse_url $url)"

sudo -u $USERNAME curl "$url" --output "$target"
sudo -u $USERNAME bash "$target" -b -p "/home/$USERNAME/miniconda"
dpkg -i "$target"

IP=$(curl -s -4 icanhazip.com)

sed -i "s/# full-node: false/full-node: true/" /etc/bee/bee.yaml /etc/bee/bee.yaml
sed -i "s/# nat-addr: \"\"/nat-addr: \"$IP:1634\"/" /etc/bee/bee.yaml /etc/bee/bee.yaml
sed -i "s/# swap-initial-deposit: 0/nat-addr: \"$IP:1634\"/" /etc/bee/bee.yaml /etc/bee/bee.yaml