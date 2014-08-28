#!/system/bin/sh

# This step will stop android UI
setprop ctl.stop media & setprop ctl.stop zygote & setprop ctl.stop surfaceflinger & setprop ctl.stop drm

#export PATH=$bin:/sbin:/usr/bin:/usr/local/bin:/usr/sbin:/bin:/usr/local/sbin:/usr/games:$PATH
#export PATH=/sbin:/usr/bin:/usr/local/bin:/usr/sbin:/bin:/usr/local/sbin:/usr/games:$PATH
#export TERM=linux

chroot_path="/data/linux"
#export HOME=/root
export HOSTNAME=localhost
#export DISPLAY=:0

# Change the path with your root file system (it can be any distro, doesn't matter)
mount /storage/sdcard1/14.04.1_rootfs.img $chroot_path

start_mount() {
	if [ ! -f "$chroot_path/proc/uptime" ]; then
		busybox mount  /proc  $chroot_path/proc
        fi

        if [ ! -f "$chroot_path/dev/random" ]; then
	        busybox mount /dev $chroot_path/dev
	        busybox mount /dev/pts $chroot_path/dev/pts
	        busybox mount /dev/cpuctl $chroot_path/dev/cpuctl
		ln -n /dev/graphics/fb0 /dev/fb0
        fi

        if [ ! -d "$chroot_path/sys/kernel" ]; then
                busybox mount /sys $chroot_path/sys
        fi
	}


stop_mount() {
	sleep 2
        umount $chroot_path/dev/pts
        umount $chroot_path/dev/cpuctl
        umount $chroot_path/dev
        umount $chroot_path/sys
        umount $chroot_path/proc
	umount $chroot_path
        }


setup() {
	busybox sysctl -w net.ipv4.ip_forward=1
	busybox chroot $chroot_path /bin/bash -c "ln -s /run/shm /dev/shm"
	busybox chroot $chroot_path /bin/bash -c "echo '127.0.0.1 localhost' > /etc/hosts"
	busybox chroot $chroot_path /bin/bash -c "echo 'shm /dev/shm tmpfs nodev,nosuid,noexec 0 0' > /etc/fstab"
	busybox chroot $chroot_path /bin/bash -c "chmod a+rw  /dev/null"
        busybox chroot $chroot_path /bin/bash -c "chmod a+rw  /dev/ptmx"
        busybox chroot $chroot_path /bin/bash -c "chmod 1777 /tmp"
        busybox chroot $chroot_path /bin/bash -c "chmod 1777 /dev/shm"
        busybox chroot $chroot_path /bin/bash -c "chmod +s /usr/bin/sudo"

	busybox chroot $chroot_path /bin/bash -c "mkdir /var/run/dbus"
        busybox chroot $chroot_path /bin/bash -c "chown messagebus.messagebus /var/run/dbus"
        busybox chroot $chroot_path /bin/bash -c "chmod 755 /var/run/dbus"

	busybox chroot $chroot_path /bin/bash -c "dpkg-divert --local --rename --add /sbin/initctl"
	busybox chroot $chroot_path /bin/bash -c "ln -s /bin/true /sbin/initctl"
	busybox chroot $chroot_path /bin/bash -c "service ssh start"
	busybox chroot $chroot_path /bin/bash -c "dbus-daemon --system --fork > /dev/null 2>&1"


	busybox chroot $chroot_path /bin/bash -c "chown -R student.student /home/student"
	busybox chroot $chroot_path /bin/bash -c "rm /tmp/.X* > /dev/null 2>&1"
	busybox chroot $chroot_path /bin/bash -c "rm -rf /tmp/*"
	busybox chroot $chroot_path /bin/bash -c "rm /tmp/.X11-unix/X* > /dev/null 2>&1"
	busybox chroot $chroot_path /bin/bash -c "rm /var/run/dbus/pid > /dev/null 2>&1"
	busybox chroot $chroot_path /bin/bash -c "groupadd -g 3003 android_inet"

}

destroy() {

	busybox chroot $chroot_path /bin/bash -c "service ssh stop"
	busybox chroot $chroot_path /bin/bash -c "service wicd stop"
	busybox chroot $chroot_path /bin/bash -c "service networking stop"
	for pid in `busybox lsof | busybox grep $mnt | busybox sed -e's/  / /g' | busybox cut -d' ' -f2`; do busybox kill -9 $pid >/dev/null 2>&1; done
}


        start_mount
	setup
        chroot $chroot_path /bin/su -l student -c 'startx'

	destroy
        stop_mount
        setprop ctl.start media & setprop ctl.start zygote & setprop ctl.start surfaceflinger & setprop ctl.start drm


# mount -o rw,remount /dev/block/mtdblock9 /system
