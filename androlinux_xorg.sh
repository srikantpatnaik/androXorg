#!/system/bin/sh

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

start_mount() {
	if [ ! -f "$chroot_path/proc/uptime" ]; then
		busybox mount  /proc  $chroot_path/proc
        fi

        if [ ! -f "$chroot_path/dev/random" ]; then
	        busybox mount /dev $chroot_path/dev
	        busybox mount /dev/pts $chroot_path/dev/pts
		ln -n /dev/graphics/fb0 /dev/fb0
        fi

        if [ ! -d "$chroot_path/sys/kernel" ]; then
                busybox mount /sys $chroot_path/sys
        fi
	}


stop_mount() {
	sleep 2
        umount $chroot_path/proc
        umount $chroot_path/dev/pts
        umount $chroot_path/dev
        umount $chroot_path/sys
	umount $chroot_path
        }


setup() {
	busybox sysctl -w net.ipv4.ip_forward=1
	busybox chroot $chroot_path /bin/bash -c "echo '127.0.0.1 localhost' > /etc/hosts"
	busybox chroot $chroot_path /bin/bash -c "echo 'shm /dev/shm tmpfs nodev,nosuid,noexec 0 0' >> /etc/fstab"
	busybox chroot $chroot_path /bin/bash -c "chmod a+rw  /dev/null"
        busybox chroot $chroot_path /bin/bash -c "chmod a+rw  /dev/ptmx"
        busybox chroot $chroot_path /bin/bash -c "chmod 1777 $chroot_path/tmp"
        busybox chroot $chroot_path /bin/bash -c "chmod 1777 $chroot_path/dev/shm"
        busybox chroot $chroot_path /bin/bash -c "chmod +s $chroot_path/usr/bin/sudo"
	busybox chroot $chroot_path /bin/bash -c "mkdir /var/run/dbus"
        busybox chroot $chroot_path /bin/bash -c "chown messagebus.messagebus /var/run/dbus"
        busybox chroot $chroot_path /bin/bash -c "chmod 755 /var/run/dbus"
	busybox chroot $chroot_path /bin/bash -c "chown -R student.student /home/student"
}


        start_mount
        chroot $chroot_path /bin/bash "startx"

        stop_mount
        setprop ctl.start media & setprop ctl.start zygote & setprop ctl.start surfaceflinger & setprop ctl.start drm


# mount -o rw,remount /dev/block/mtdblock9 /system
