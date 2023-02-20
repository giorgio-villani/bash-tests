#!/bin/bash

current_datetime=$(date +"%Y-%m-%d_%T")
cp /etc/fstab "/etc/fstab_${current_datetime}.bak"

# Get a list of all the sd drives
drives=$(lsblk -d -o NAME,TYPE | grep sd | awk '{print $1}')
# echo $drives
index=0

# Loop through the list of drives
for drive in $drives; do
  # Get the UUID of the drive
  let index=$((index + 1))
  drive_label="drive_$index"
  uuid=$(lsblk -o NAME,UUID | grep $drive | awk '{print $2}' | tr -d '\n')
  fstype=$(lsblk -o NAME,FSTYPE | grep $drive | awk '{print $2}' | tr -d '\n')
  label=$(lsblk -o NAME,LABEL | grep $drive | awk '{print $2}' | tr -d '\n')
  folder_path="/home/user01/sambashare/mnt/$label"
  record="/dev/disk/by-uuid/${uuid} $folder_path ${fstype} defaults 0 1"

  if [ ! -d "$folder_path" ]; then
    # create the folder if it doesn't exist
    mkdir "$folder_path"
    echo "Folder $folder_path created"
  else
    # the folder exists
    echo "Folder $folder_path already exists"
  fi

  # Check if the drive is already in fstab
  if grep -q $uuid /etc/fstab; then
    echo "Drive $drive is already in fstab"
  else
    # Add the drive to fstab
    echo "$record" >> /etc/fstab
    echo "Added drive $drive to fstab"
  fi
done
