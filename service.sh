# Disable ADB Root for Security Purpose
MODPATH=${0%/*}
MODDIR=${0%/*}
sleep 60
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi

# ZRAM Swap Virtual Memory
MODPATH=${0%/*}
MODDIR=${0%/*}
sleep 1
ZRAM=/block/zram0
swapoff /dev$ZRAM
DISKSIZEDEF=`cat /sys$ZRAM/disksize`
DISKSIZE=
#%MemTotalStr=`cat /proc/meminfo | grep MemTotal`
#%MemTotal=${MemTotalStr:16:8}
#%let VALUE="$MemTotal * VAR / 100"
#%DISKSIZE=$VALUE\K
swapoff /dev$ZRAM
echo 1 > /sys$ZRAM/reset
ALGODEF=`cat /sys$ZRAM/comp_algorithm`
ALGO=
[ "$ALGO" ] && echo "$ALGO" > /sys$ZRAM/comp_algorithm
#oecho "$DISKSIZE" > /sys$ZRAM/disksize
#omkswap /dev$ZRAM
PRIO=
#o/system/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /system/vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| swapon /dev$ZRAM

# Device/Kernel Settings/Parameters Configuration
MODPATH=${0%/*}
MODDIR=${0%/*}
sleep 60
sh $MODPATH/system_settings.sh

sleep 1
sh $MODPATH/system_governors.sh

sleep 1
sh $MODPATH/system_kernel.sh

sleep 1
sh $MODPATH/system_cpu_gpu_power.sh