HOW TO
======

This repository contains a step by step tutorial to bring ``Xorg`` and other
GNU/Linux components using chroot-linux.

Prerequisites
-------------

* Rooted Android with loop device support in Kernel

* Basic understanding of GNU/Linux command line tools, Xorg configurations

Execution
---------

* Copy the ``androlinux_xorg.sh`` script to ``/data``, edit script to point location
  of ``img`` file correctly

* Execute ::

	cd /data && sh androlinux_xorg.sh &

  This will switch to GNU/Linux and to exit, do ``logout`` in LXDE menu, it will bring
  back the Android.


Build Process
-------------

This documentation will use ``ubuntu-14.04.1 armhf`` image for filesystem.
