#!/system/bin/sh
# Initialize variables at once
MODPATH="${0%/*}"
MODDIR="${0%/*}"

# Apply-On-Boot section
# You can configure it below the "done" word
# If you want to increase time before apply-on-boot are in effect
MODPATH=${0%/*}
MODDIR=${0%/*}
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done
while [ -z "$(pm path android 2>/dev/null)" ]; do
    sleep 1
done
sleep 1
if [ "$(getprop sys.init.perf_lsm)" = "basic" ] || [ "$(getprop init.svc.goldfish-logcat)" = "running" ]; then
    exit 0
fi
# All Mods/Tweaks/Others parameters will be modified/applied after configured times are elapsed

# System Files Permissions.
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi

# OS System SELinux and ADB Root Modifications
if [ -x "$(command -v resetprop)" ]; then
    resetprop -n ro.boot.selinux enforcing
    if [ -n "$(resetprop ro.build.selinux)" ]; then
        resetprop --delete ro.build.selinux
    fi
fi
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi

# Android Device/Kernel ZRAM Swap Virtual Memory Modifications
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

# Android Device/Kernel Settings/Parameters Modifications
[ -f "$MODPATH/system_settings.sh" ] && sh "$MODPATH/system_settings.sh"
[ -f "$MODPATH/system_governors.sh" ] && sh "$MODPATH/system_governors.sh"
[ -f "$MODPATH/system_kernel.sh" ] && sh "$MODPATH/system_kernel.sh"
[ -f "$MODPATH/system_cpu_gpu_power.sh" ] && sh "$MODPATH/system_cpu_gpu_power.sh"

# System Files Permissions
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi