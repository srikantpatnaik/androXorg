#!/bin/bash

# A simple batery monitor script using 'notify send'
# copyright Srikant Patnaik
# GNU GPLv3

# Present voltage of device
voltage_now=$(cat /sys/class/power_supply/battery/voltage_now)

# Find out the minimum voltage at which your device shutdowns, in my case its this
voltage_min=3600

# scale=2 is required for decimal upto 2 digits, 'bc' is the calculator
notify-send  $(echo "scale=2;($voltage_now-$voltage_min)/530*100"|bc|cut -d '.' -f1)% remaining

