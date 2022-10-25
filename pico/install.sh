
INITRD_IMG=initrd.img
INITRD_DIR=initrd
BOOT_DEV=/dev/sda
BOOT_PART=${BOOT_DEV}1


mkdir -p ${INITRD_DIR}
mount ${INITRD_IMG} ${INITRD_DIR}
cd ${INITRD_DIR} 
cp -p ../pico/linuxrc .  
cp -p ../pico/ash . 
mkdir -p dev 
mknod dev/console c 5 1 
cd ..
umount ${INITRD_DIR}
gzip ${INITRD_IMG}
mkdir -p p1
mount ${BOOT_PART} p1
cp ${INITRD_IMG}.gz p1/picord.gz
cp syslinux.cfg p1/
umount p1
