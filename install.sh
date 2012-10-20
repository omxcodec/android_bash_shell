#!/bin/bash
adb root
adb remount

adb shell mkdir -p /system/etc/bash
adb push bash_logout /system/etc/bash
adb push bashrc /system/etc/bash
adb push bash /system/xbin
adb push busybox /system/xbin

adb shell sync
