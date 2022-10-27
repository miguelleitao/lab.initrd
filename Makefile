
INITRD_IMG=initrd.img
INITRD_DIR=initrd
BOOT_DEV=/dev/sda
BOOT_PART=${BOOT_DEV}1

default:

${INITRD_IMG}.gz:
	dd if=/dev/zero of=${INITRD_IMG} bs=1M count=20
	mkfs -t ext2 ${INITRD_IMG}
	gzip ${INITRD_IMG}

${INITRD_IMG}: ${INITRD_IMG}.gz
	gunzip $<

picord: ${BOOT_PART} ${INITRD_IMG}
	./pico/install.sh

micrord: ${BOOT_PART} ${INITRD_IMG}
	./micro/install.sh

minird: ${BOOT_PART} ${INITRD_IMG}
	./mini/install.sh

fullrd: ${BOOT_PART} ${INITRD_IMG}
	./full/install.sh

picord_old: ${BOOT_PART} ${INITRD_IMG}
	mkdir -p ${INITRD_DIR}
	mount ${INITRD_IMG} ${INITRD_DIR}
	@cd ${INITRD_DIR} ;\
	cp -p ../pico/linuxrc .  ;\
	cp -p ../pico/ash . ;\
	mkdir -p dev ;\
	mknod dev/console c 5 1 
	umount ${INITRD_DIR}
	gzip ${INITRD_IMG}
	mkdir -p p1
	mount ${BOOT_PART} p1
	cp ${INITRD_IMG}.gz p1/picord.gz
	cp syslinux.cfg p1/
	umount p1

micrord_old: ${BOOT_PART} ${INITRD_IMG}
	mkdir -p ${INITRD_DIR}
	mount ${INITRD_IMG} ${INITRD_DIR}
	@cd ${INITRD_DIR} ;\
	rm -f ash ;\
	mkdir -p bin ;\
	pwd ;\
	cp -p ../micro/busybox bin/ ;\
	../MakeLinks -f bin ;\
	cp -p ../micro/linuxrc .  ;\
	mkdir -p dev/pts ;\
	mknod dev/tty c 5 0 ;\
	mknod dev/tty1 c 4 1 
	umount ${INITRD_DIR}
	gzip ${INITRD_IMG}
	mkdir -p p1
	mount ${BOOT_PART} p1
	cp ${INITRD_IMG}.gz p1/micrord.gz
	umount p1

minird_old: ${BOOT_PART} ${INITRD_IMG}
	mkdir -p ${INITRD_DIR}
	mount ${INITRD_IMG} ${INITRD_DIR}
	@cd ${INITRD_DIR} ;\
	mkdir -p proc ;\
	mkdir -p bin ;\
	rm -f bin/ash ;\
	cp -p ../mini/ash bin/ ;\
	../MakeLinks -f bin ;\
	cp -p ../mini/linuxrc .  ;\
	mkdir -p dev/pts ;\
	mknod dev/tty c 5 0 ;\
	mknod dev/tty1 c 4 1 ;\
	mknod dev/hda b 3 0 ;\ ;\
	mknod dev/hda1 b 3 1 ;\ ;\
	mknod dev/hda2 b 3 2 ;\
	umount ${INITRD_DIR}
	gzip ${INITRD_IMG}
	mkdir -p p1
	mount ${BOOT_PART} p1
	cp ${INITRD_IMG}.gz p1/minird.gz
	umount p1


clear:
	rm -f initrd.img initrd.img.gz	
