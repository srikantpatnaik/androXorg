/etc/rc.local
=============

The entries from this file will go to `/etc/rc.local`, which will be
run as root, when system init finishes.

Commands to disable resize in certain netbooks ::

	cp /media/boot/scriptcmd.failsafe /media/boot/scriptcmd
	echo "$(date +%d-%m-%Y_%T); copied scriptcmd.failsafe to scriptcmd" >> /var/log/rc.local.log

