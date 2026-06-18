# Apply-on-boot section.
# You can configure it below the "done" word.
# If you want to increase time before apply-on-boot are in effect.
# Don't modify the other as they already good as it.
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 60
# All Mods/Tweaks/Others parameters will be applied after configured times are elapsed.

# System Files Permissions
sh $MODPATH/system_files_chmods-1.sh

# Device and System SELinux
# Don't mind about this section if you don't know about it and just leave it as it is.
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
sh $MODPATH/system_selinux.sh
if [ -x "\$(command -v resetprop)" ]
then
	resetprop -n ro.boot.selinux enforcing
fi
if [ -x "\$(command -v resetprop)" ] && [ -n "\$(resetprop ro.build.selinux)" ]
then
	resetprop --delete ro.build.selinux
fi

# Disable ADB Root for Security Purpose
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi

# ZRAM Swap Virtual Memory
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
ZRAM=/block/zram0
swapoff /dev$ZRAM
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
DISKSIZEDEF=`cat /sys$ZRAM/disksize`
DISKSIZE=
#%MemTotalStr=`cat /proc/meminfo | grep MemTotal`
#%MemTotal=${MemTotalStr:16:8}
#%let VALUE="$MemTotal * VAR / 100"
#%DISKSIZE=$VALUE\K
swapoff /dev$ZRAM
echo 1 > /sys$ZRAM/reset
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
ALGODEF=`cat /sys$ZRAM/comp_algorithm`
ALGO=
[ "$ALGO" ] && echo "$ALGO" > /sys$ZRAM/comp_algorithm
#oecho "$DISKSIZE" > /sys$ZRAM/disksize
#omkswap /dev$ZRAM
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
PRIO=
#o/system/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /system/vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| swapon /dev$ZRAM

# Device/Kernel Settings/Parameters Configuration
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
sh $MODPATH/system_settings.sh
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
sh $MODPATH/system_governors.sh
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
sh $MODPATH/system_kernel.sh
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
sh $MODPATH/system_cpu_gpu_power.sh

# System Files Permissions
sh $MODPATH/system_files_chmods-2.sh