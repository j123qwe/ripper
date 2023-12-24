#!/bin/bash

# https://linux.die.net/man/1/abcde
# https://www.andrews-corner.org/abcde/

_NFSIP="192.168.1.1"
_NFSPATH="/volume1/Music"

sudo mkdir -p /mnt/nfs
sudo mount -t nfs ${_NFSIP}:${_NFSPATH} /mnt/nfs


echo 0 > /proc/sys/dev/cdrom/autoclose

while true; do
    blockdev --getsize64 /dev/cdrom 2>/dev/null
    if [ $? -eq 0 ]; then
      abcde -c abcde.conf
    fi
    echo "Waiting for the next CD..."
    sleep 5
done



