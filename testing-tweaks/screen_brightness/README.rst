Brightness control
==================

Add the following line in `/etc/rc.local` to make it a startup job ::

	sudo chmod o+w /sys/class/backlight/<somefile>/brightness

Now with a simple bash script we can `echo` suitable values to
above `brightness` file and change the brightness of the screen. It would
be a good practice to know the max brightness allowed by reading the file ::

	cat /sys/class/backlight/<somefile>/max_brightness

Now to set brightness we use ::

	echo 50 > /sys/class/backlight/<somefile>/brightness


