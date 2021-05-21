#!/bin/bash -u

# Variable to check the humber of mounted drives
mountNum="$(mount | grep -ci "datadump")"

# Variable to check the number of drives to be mapped
mounted="$(mount | grep -ic 'datadump' /etc/fstab)"

# If statement, to check and see if the number of mapped drives are correct,
# if not, it will map everything again.
if [[ "$mountNum" -ne "$mounted" ]] ; then
        mount -a
fi
