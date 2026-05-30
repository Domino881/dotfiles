#!/bin/bash

# BACKUPDIR="/run/user/1000/gvfs/smb-share:server=192.168.90.5,share=backup/Dominik/backup-dominiklaptop/$(date +%Y%m%d)"
# umount /run/user/1000/gvfs/smb-share:server=192.168.90.5,share=backup
sudo mount -t nfs 192.168.90.5:/VOL1/BACKUP /mnt/home-nas/BACKUP
# BACKUPDIR="/mnt/home-nas/BACKUP/Dominik/backup-dominiklaptop/RSYNC_BACKUP"
BACKUPDIR="/run/media/dominik/WD Elements/dominik-backup/dominik-rsync/"

rsync -rlDizu --partial --info=progress2\
    --exclude=".cache"\
    --exclude="*/cache"\
    --exclude="*/Cache"\
    --exclude=".mozilla"\
    --exclude=".cargo"\
    --exclude=".npm"\
    --exclude="node_modules"\
    --exclude="go"\
    --exclude=".rustup"\
    --exclude=".steam"\
    --exclude=".local/share/Steam"\
    --exclude=".trash"\
    --exclude=".local/share/Trash"\
    --exclude="*.git"\
    --exclude=".local/share/nvim/lazy"\
    --exclude=".local/share/nvim/mason"\
    --exclude=".Wolfram"\
    --exclude="*venv"\
    --exclude=".julia"\
    "$HOME" "$BACKUPDIR"
