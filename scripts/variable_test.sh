#!/bin/bash

# parse url
parse_url() {
    if [ -z $LINODE_ID]; then
        echo "${1##*/}"
    else
        echo "${1##*/}"
    fi
}

target="/home/$USERNAME/Downloads/$(parse_url $url)"
echo $target