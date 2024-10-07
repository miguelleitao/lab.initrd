
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /dev/bootdev"
  exit
fi
INITRD_IMG=initrd.img
INITRD_DIR=initrd
#BOOT_DEV=/dev/sda
BOOT_DEV=$1
BOOT_PART=${BOOT_DEV}1

echo "# Setup picord into ${INITRD_IMG}.gz"
mkdir -p ${INITRD_DIR}
#gunzip ${INITRD_IMG}.gz
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
cp linux24 p1/
umount p1

