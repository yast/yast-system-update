#!/bin/bash

# define temporary directory - cannot use YaST, since it needs to persist
# multiple runs of YaST

export UPDATE_TMP_DIR=`mktemp -d`;

test -d $UPDATE_TMP_DIR || ( echo "Failed to create temporary directory" && exit 1 );

echo "Created tmp dir $UPDATE_TMP_DIR";

# start YaST to define installation repo
# prepare inst-sys image in the temporary dir
# write install.inf

/sbin/yast2 system-update || ( echo "Failed to run YaST" && exit 2 );

# bind-mount root /sys /proc
mkdir "$UPDATE_TMP_DIR/sys" 2>/dev/null ; mount --rbind /sys "$UPDATE_TMP_DIR/sys"
mkdir "$UPDATE_TMP_DIR/proc" 2>/dev/null ; mount --rbind /proc "$UPDATE_TMP_DIR/proc"
mkdir "$UPDATE_TMP_DIR/mnt" 2>/dev/null ; mount --rbind / "$UPDATE_TMP_DIR/mnt"

# run YaST in chroot

# FIXME ensure somehow about using different workflow - will be tricky :-(
chroot $UPDATE_TMP_DIR /usr/lib/YaST2/startup/YaST2.First-Stage

# FIXME remove following line
exit 0;

# ummount (incl. /proc, /sys)
umount $UPDATE_TMP_DIR/mnt || ( echo "Umount failed" && exit 99 );
umount $UPDATE_TMP_DIR/proc || ( echo "Umount failed" && exit 99 );
umount $UPDATE_TMP_DIR/sys || ( echo "Umount failed" && exit 99 );

# clean-up
rm -rf $UPDATE_TMP_DIR;

exit 0;
