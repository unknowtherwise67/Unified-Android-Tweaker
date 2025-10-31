# ZRAM Swap Virtual Memory
MODPATH=${0%/*}
MODDIR=${0%/*}
ZRAM=/block/zram0

swapoff /dev$ZRAM

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done

DEF=`cat /sys$ZRAM/disksize`
DEF=`cat /sys$ZRAM/comp_algorithm`
DEF=`cat /proc/sys/vm/swappiness`
DEF=`getprop ro.lmk.swap_free_low_percentage`

DISKSIZE=1G
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
PRIO=0
#o/system/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| swapon /dev$ZRAM

# Device/Kernel Settings/Parameters Configuration
MODPATH=${0%/*}
MODDIR=${0%/*}
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 120
sh $MODPATH/system_settings.sh

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 5
fstrim -v /cache
fstrim -v /data
fstrim -v /system

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 5
sh $MODPATH/system_cpu_cores.sh

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

# ZRAM Swap Virtual Memory Functions
MODPATH=${0%/*}
MODDIR=${0%/*}
lmk_prop() {
resetprop -n ro.lmk.swap_free_low_percentage "$SFLP"
resetprop lmkd.reinit 1
}
stop_log() {
SIZE=`du $LOGFILE | sed "s|$LOGFILE||g"`
if [ "$LOG" != stopped ] && [ "$SIZE" -gt 25 ]; then
  exec 2>/dev/null
  set +x
  LOG=stopped
fi
}
lmk_config() {
stop_log
sleep 5
DEF=`device_config get lmkd_native swap_free_low_percentage`
DEF2=`getprop persist.device_config.lmkd_native.swap_free_low_percentage`
if [ "$DEF" != null ] || [ "$DEF2" ]; then
  device_config delete lmkd_native swap_free_low_percentage
  resetprop -p --delete persist.device_config.lmkd_native.swap_free_low_percentage
  resetprop lmkd.reinit 1
fi
lmk_config
}

SFLP=0
lmk_prop
lmk_config

# Exit after completions
exit 0