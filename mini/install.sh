
INITRD_IMG=initrd.img
INITRD_DIR=initrd
BOOT_DEV=/dev/sda
BOOT_PART=${BOOT_DEV}1

mkdir -p ${INITRD_DIR}
mount ${INITRD_IMG} ${INITRD_DIR}
cd ${INITRD_DIR} 
mkdir -p proc 
mkdir -p bin 
rm -f bin/ash 
cp -p ../mini/ash bin/ 
../MakeLinks -f bin 
cp -p ../mini/linuxrc .  
mkdir -p boot 
mkdir -p root
mkdir -p dev/pts 
mknod dev/tty c 5 0 
mknod dev/tty1 c 4 1 
#mknod dev/sda b 8 0 
#mknod dev/sda1 b 8 1 
#mknod dev/sda2 b 8 2 
mknod dev/hda b 3 0
mknod dev/hda1 b 3 1
mknod dev/hda2 b 3 2
cd ..
umount ${INITRD_DIR}
gzip ${INITRD_IMG}
mkdir -p p1
mount ${BOOT_PART} p1
cp ${INITRD_IMG}.gz p1/minird.gz
umount p1


