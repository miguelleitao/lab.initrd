
INITRD_IMG=initrd.img
INITRD_DIR=initrd
BOOT_DEV=/dev/sda
BOOT_PART=${BOOT_DEV}1

mkdir -p ${INITRD_DIR}
mount ${INITRD_IMG} ${INITRD_DIR}
cd ${INITRD_DIR} 
rm -f ash 
mkdir -p bin 
cp -p ../micro/busybox bin/ 
../MakeLinks -f bin 
cp -p ../micro/linuxrc .  
mkdir -p dev/pts 
mknod dev/tty c 5 0 
mknod dev/tty1 c 4 1 
cd ..
umount ${INITRD_DIR}
gzip ${INITRD_IMG}
mkdir -p p1
mount ${BOOT_PART} p1
cp ${INITRD_IMG}.gz p1/micrord.gz
umount p1

