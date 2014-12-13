SIMPLE BATTERY MONITOR FOR XFCE
===============================

This is a simple script to enable battery monitor in most ARM based GNU/Linux
systems. The missing ACPI in ARM environment makes it difficult for battery
status to reflect on desktop.

The script is quite simple and just require following commands, in most modern
desktop they come preinstalled:

#. bc

#. notify-send

Create a program launcher from XFCE menu and add path to your script, similar to this ::

	bash /opt/battery_status.sh

Add a battery icon if you wish.

Due to lack of battery charging/discharging status in my case, I haven't added any,
otherwise you may add that too.

