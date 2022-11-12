#!/bin/bash

mkdir "/home/$USERNAME/$VOLUME_NAME"
mount "/dev/disk/by-id/scsi-0Linode_Volume_my-cloned-volume" "/home/$USERNAME/$VOLUME_NAME"
chown $USERNAME $VOLUME_NAME/
echo "/dev/disk/by-id/scsi-0Linode_Volume_$VOLUME_NAME /home/$USERNAME/$VOLUME_NAME ext4 defaults,noatime,nofail 0 2" | sudo tee -a /etc/fstab
