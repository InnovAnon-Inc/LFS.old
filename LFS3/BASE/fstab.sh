set -eo nounset
set +h

test -e /etc/fstab || \
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/sda4      /            ext4     defaults            1     1
/dev/sda3      swap         swap     pri=1               0     0
proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0

#noauto,user,quiet,showexec,iocharset=koi8r,codepage=866
#noauto,user,quiet,showexec,iocharset=utf8,codepage=866

/dev/sda2      /mnt/slacko  ext4     defaults            2     2

/mnt/slacko/ccache.img /root/.ccache ext4 defaults,loop 0 0
/mnt/slacko/sources    /sources      none defaults,bind 0 0
/mnt/slacko/repos      /repos        none defaults,bind 0 0
# /workspace

# End /etc/fstab
EOF

# TODO
hdparm -I /dev/sda | grep NCQ
