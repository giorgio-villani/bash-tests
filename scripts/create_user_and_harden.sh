#!/bin/bash

echo "creating user $USER"
adduser --disabled-login --gecos '' --shell /bin/bash $USER
usermod -aG sudo $USER
passwd -d $USER

# setup key login
sudo -u $USER mkdir -p "/home/$USER/.ssh"
sudo -u $USER chmod 700 "/home/$USER/.ssh"
sudo -u $USER echo "$SSH_KEY" > "/home/$USER/.ssh/authorized_keys"
chown $USER "/home/$USER/.ssh/authorized_keys"
sudo -u $USER chmod 600 "/home/$USER/.ssh/authorized_keys"
echo "[x] ssh keys installed"

# remove root permissions
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config /etc/ssh/sshd_config
/etc/init.d/ssh restart
echo "[x] password access and root access removed"
