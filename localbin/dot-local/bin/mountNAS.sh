#!/bin/bash
FOLDERS="BACKUP Audio FOTO"

for f in $FOLDERS; do
    mountpoint -q /mnt/home-nas/$f || sudo mount -t ntfs -o username=dkuczynski //192.168.90.5/VOL1/$f /mnt/home-nas/$f && echo "$f mounted"
done
