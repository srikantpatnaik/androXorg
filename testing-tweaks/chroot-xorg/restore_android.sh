#!/system/bin/sh
# A simple unmount script
chroot_path=/data/linux

stop_mount() {
        umount $chroot_path/proc
        umount $chroot_path/dev/pts
        umount $chroot_path/dev
        umount $chroot_path/sys
        }


        stop_mount
	# Start Android again (assuming Xorg has been stopped)
        setprop ctl.start media & setprop ctl.start zygote & setprop ctl.start surfaceflinger & setprop ctl.start drm


