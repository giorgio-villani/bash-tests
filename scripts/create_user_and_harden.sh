#!/bin/bash

echo "creating user $USERNAME"
adduser --disabled-login --gecos '' --shell /bin/bash $USERNAME
usermod -aG sudo $USERNAME
passwd -d $USERNAME

# setup key login
sudo -u $USERNAME mkdir -p "/home/$USERNAME/.ssh"
sudo -u $USERNAME chmod 700 "/home/$USERNAME/.ssh"
sudo -u $USERNAME echo "$SSH_KEY" > "/home/$USERNAME/.ssh/authorized_keys"
chown $USERNAME "/home/$USERNAME/.ssh/authorized_keys"
sudo -u $USERNAME chmod 600 "/home/$USERNAME/.ssh/authorized_keys"
echo "[x] ssh keys installed"

# remove root permissions
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config /etc/ssh/sshd_config
/etc/init.d/ssh restart
echo "[x] password access and root access removed"
