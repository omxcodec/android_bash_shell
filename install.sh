#!/bin/bash
adb root
adb remount

adb shell mkdir -p /system/etc/bash
adb push bash_logout /system/etc/bash
adb push bashrc /system/etc/bash
adb push bash /system/xbin
adb push busybox /system/xbin

exist=$(adb shell "if [ -f "/system/lib/libncurses.so" ]; then echo "YES"; else echo "NO"; fi")

# $exist len: NO is 3; YES is 4!
#echo $exist
#len=`expr length $exist`
#echo len=$len

if [ ${exist:0:2} == "NO" ]; then
adb push libncurses.so /system/lib
fi

adb shell sync
