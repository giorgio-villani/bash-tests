#!/bin/bash

# update and upgrade
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt install -y build-essential
# reboot