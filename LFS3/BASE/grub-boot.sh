set -eo nounset
set +h

# make boot ISO
#../BLFS/libburn.sh
#../BLFS/libiso.sh
#../BLFS/libisoburn.sh
#
#cd /tmp 
#grub-mkrescue --output=grub-img.iso 
#xorriso -as cdrecord -v dev=/dev/cdrw blank=as_needed grub-img.iso
#
#rm grub-img.iso

# overwrite current boot loader
#grub-install /dev/sda

#	--pubkey=?               \
#	--themes=?               \

grub-install \
	--compress=xz            \
	--locales=POSIX          \
	--bootloader-id=lfs-grub \
	--core-compress=xz       \
	--efi-directory=/efi     \
	--no-bootsector          \
	--removable              \
        --recheck                \
        --debug                  \
	/dev/sda

#efibootmgr -c -d /dev/sda -p 4 -l '\EFI\lfs-grub\bootx86.efi' -L 'LFS Grub BootLoader'

test -e /boot/grub/grub.cfg || \
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,4)

menuentry "GNU/Linux, Linux 4.13.7-lfs-SVN-20171015" {
	# if using a separate boot partition,
	# then remove /boot file path prefix
        linux   /boot/vmlinuz-4.13.7-lfs-SVN-20171015 root=/dev/sda4 ro
}
EOF

# TODO grub-mkconfig

