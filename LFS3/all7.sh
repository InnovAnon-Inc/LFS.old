set -eo nounset

export LFS=/mnt/lfs

# TODON'T
#./preparing-virtual-kernel-file-systems.sh

# this handles the case when the host has a separate /boot partition
mount --bind /boot $LFS/boot
trap "umount -f /boot $LFS/boot" 0

chroot "$LFS" /usr/bin/env -i \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='\u:\w\$ '              \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash +h << EOF
cd /workspace/LFS/LFS3/BASE
./base5.sh
EOF
