# Disable ADB Root for Security Purpose
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
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
ZRAM=/block/zram0
swapoff /dev$ZRAM
DEF=`cat /sys$ZRAM/disksize`
DEF=`cat /sys$ZRAM/comp_algorithm`
DEF=`cat /proc/sys/vm/swappiness`
DEF=`getprop ro.lmk.swap_free_low_percentage`
DISKSIZE=
#%MemTotalStr=`cat /proc/meminfo | grep MemTotal`
#%MemTotal=${MemTotalStr:16:8}
#%let VALUE="$MemTotal * VAR / 100"
#%DISKSIZE=$VALUE\K
swapoff /dev$ZRAM
echo 1 > /sys$ZRAM/reset
ALGO=
if [ "$ALGO" ]; then
  echo "$ALGO" > /sys$ZRAM/comp_algorithm
fi
#oecho "$DISKSIZE" > /sys$ZRAM/disksize
#omkswap /dev$ZRAM
PRIO=
#o/system/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| swapon /dev$ZRAM

# Device/Kernel Settings/Parameters Configuration
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 60
sh $MODPATH/system_settings.sh

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 5
sh $MODPATH/system_governors.sh

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 5
sh $MODPATH/system_kernel.sh

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 5
sh $MODPATH/system_cpu_gpu_power.sh

# Exit after completions
exit 0