
INITRD_IMG=initrd.img
INITRD_DIR=initrd
BOOT_DEV=/dev/sda
BOOT_PART=${BOOT_DEV}1

mkdir -p ${INITRD_DIR}
mount ${INITRD_IMG} ${INITRD_DIR}
cd ${INITRD_DIR} 
mkdir -p newroot 
cp -p ../full/linuxrc .  
cd ..
umount ${INITRD_DIR}
gzip ${INITRD_IMG}
mkdir -p p1
mount ${BOOT_PART} p1
cp ${INITRD_IMG}.gz p1/fullrd.gz
umount p1

mkfs -t ext2 /dev/sda2
mkdir -p p2
mount /dev/sda2 p2
cd p2
tar xzf ../full/files.tgz
cd ..
sync
umount p2

