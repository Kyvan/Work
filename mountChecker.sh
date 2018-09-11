#!/bin/bash -u

# Variable to hold the humber of mounted drives
mountNum=`mount | grep -ci "datadump"`

# If statement, to check and see if the number of mapped drives are correct,
# if not, it will map everything again.
if [[ $mountNum -ne `mount | grep -ic 'datadump' /etc/fstab` ]] ; then
        mount -a
fi
