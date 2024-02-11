#!/bin/bash

# https://linux.die.net/man/1/abcde
# https://www.andrews-corner.org/abcde/

checkApps(){
for _PKG in ${_PACKAGES}; do
 dpkg -s ${_PKG} &> /dev/null
 if [ $? -eq 1 ]; then
  echo "Please install ${_PKG}. Exiting..."
  exit 1
 fi
done
}

_PACKAGES="abcde flac nfs-common"
_DEVICE=/dev/sr1
_NFSIP="192.168.1.1"
_NFSPATH="/volume1/Music"


checkApps
sudo mkdir -p /mnt/nfs
sudo mount -t nfs ${_NFSIP}:${_NFSPATH} /mnt/nfs


echo 0 > /proc/sys/dev/cdrom/autoclose

while true; do
    blockdev --getsize64 ${_DEVICE} 2>/dev/null
    if [ $? -eq 0 ]; then
      abcde -c abcde.conf -d ${_DEVICE}
    fi
    echo "Waiting for the next CD..."
    sleep 5
done



