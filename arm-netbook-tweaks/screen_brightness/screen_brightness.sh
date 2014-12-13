#!/bin/bash

# A simple script to control screen brightness using 'notify send'
# copyright Srikant Patnaik
# GNU GPLv3

# Three brightness modes
brightness_max=250
brightness_med=160
brightness_low=80

# A file to store previous brightness value
status_file=/tmp/previous_brightness

# If running for first time, then create the status file with med value for brightness
if [ ! -f $status_file ];
then
        echo $brightness_med > $status_file
fi

previous_brightness=$(cat $status_file)

if (( "$previous_brightness" == "80" ));
then
	echo $brightness_med > /sys/class/backlight/pwm-backlight.0/brightness
        notify-send "medium brightness"
        echo $brightness_med > $status_file

elif (( "$previous_brightness" == "160" ));
then
	echo $brightness_max > /sys/class/backlight/pwm-backlight.0/brightness
        notify-send "full brightness" 
        echo $brightness_max > $status_file
else
	echo $brightness_low > /sys/class/backlight/pwm-backlight.0/brightness
        notify-send "low brightness"
        echo $brightness_low > $status_file
fi
