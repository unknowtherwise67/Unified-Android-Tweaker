# ZRAM Virtual Memory
MODPATH=${0%/*}
MODDIR=${0%/*}
swapoff /dev/block/zram0

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1

DEF=`cat /sys/block/zram0/disksize`
DEF=`cat /sys/block/zram0/comp_algorithm`
DEF=`cat /proc/sys/vm/swappiness`
DEF=`getprop ro.lmk.swap_free_low_percentage`
DEF=`getprop ro.lmk.thrashing_limit_critical`

#ALGO=
#oZRAM=1GBs
#%MemTotalStr=`cat /proc/meminfo | grep MemTotal`
#%MemTotal=${MemTotalStr:16:8}
#%let VALUE="$MemTotal * VAR / 100"
#%ZRAM=$VALUE\K
swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
if [ "$ALGO" ]; then
  echo "$ALGO" > /sys/block/zram0/comp_algorithm
fi
#oecho 100 > /proc/sys/vm/swappiness
#oecho "$ZRAM" > /sys/block/zram0/disksize
#omkswap /dev/block/zram0
#oswapon /dev/block/zram0

# Kernel Tweaks
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 1
sh $MODPATH/tweaker.sh

# Exit after completions
exit 0