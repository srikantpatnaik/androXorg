#!/system/bin/sh

# To run this script, first ssh to Android using sshdroid or similar utility.
# This step will stop android UI
setprop ctl.stop media & setprop ctl.stop zygote & setprop ctl.stop surfaceflinger & setprop ctl.stop drm

export PATH=$bin:/usr/bin:/usr/local/bin:/usr/sbin:/bin:/usr/local/sbin:/usr/games:$PATH
export TERM=linux

chroot_path="/data/linux"
export HOME=/root
export HOSTNAME=netbook
export DISPLAY=:0



# Change the path with your root file system (it can be any distro, doesn't matter)
mount /storage/sdcard1/14.04.1_rootfs.img $chroot_path

start_mount()
	{
        if [ ! -f "$chroot_path/proc/uptime" ]; then
               #mount --bind /proc $chroot_path/proc
		busybox mount -t proc proc  $chroot_path/proc
        fi

        if [ ! -f "$chroot_path/dev/random" ]; then
                #mount --bind /dev $chroot_path/dev
	        busybox mount -t devtmpfs devtmpfs $chroot_path/dev
               # mount --bind /dev/pts $chroot_path/dev/pts
	        busybox mount -t devpts devpts $chroot_path/dev/pts
		ln -n /dev/graphics/fb0 /dev/fb0
        fi

        if [ ! -d "$chroot_path/sys/kernel" ]; then
                #mount --bind /sys $chroot_path/sys
                busybox mount -t sysfs sysfs $chroot_path/sys
        fi

 #       if [ ! -d "$chroot_path/dev/pts" ]; then
 #               mount --bind /dev/pts $chroot_path/dev/pts
 #       fi
	 }


        start_mount
        chroot $chroot_path /bin/bash "startx &"

# mount -o rw,remount /dev/block/mtdblock9 /system
