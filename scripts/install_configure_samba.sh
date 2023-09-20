#!/bin/bash

# Check if the directory exists
if [ -z "$1" ]; then
  echo "Error: No directory specified."
  echo "Usage: $0 /path/to/directory"
  exit 1
fi

if [ ! -d "$1" ]; then
  echo "Error: The specified path is not a directory."
  exit 1
fi

# Update package list
apt update

# Install Samba
apt install -y samba

# Use the specified directory
share_path="$1"

# Set permissions (Warning: This is insecure!)
chmod 777 "$share_path"

# Add configuration to smb.conf
cat <<EOL >> /etc/samba/smb.conf

[MyShare]
   path = $share_path
   writable = yes
   guest ok = yes
   guest only = yes
   read only = no
   create mode = 0777
   directory mode = 0777
EOL

# Restart Samba service to apply changes
systemctl restart smbd

echo "Samba has been configured. You should be able to access the folder at \\\\$(hostname -I | cut -d' ' -f1)\\MyShare from a Windows machine."
