#!/system/bin/sh
# Initialize variables at once
MODPATH="${0%/*}"
MODDIR="${0%/*}"

# Apply-On-Pre/Post-Boot section
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 3
done
while [ -z "$(pm path android 2>/dev/null)" ]; do
    sleep 3
done
sleep 3
if [ "$(getprop sys.init.perf_lsm)" = "basic" ] || [ "$(getprop init.svc.goldfish-logcat)" = "running" ]; then
    exit 0
fi
# All Mods/Tweaks/Others parameters will be modified/applied after configured times are elapsed

# System Files Permissions.
sleep 3
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi

# OS System SELinux and ADB Root Modifications
sleep 3
if [ -x "$(command -v resetprop)" ]; then
    resetprop -n ro.boot.selinux enforcing
    if [ -n "$(resetprop ro.build.selinux)" ]; then
        resetprop --delete ro.build.selinux
    fi
fi
sleep 3
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi

# Android Device/Kernel ZRAM Swap Virtual Memory Modifications
sleep 3
ZRAM=/block/zram0
swapoff /dev$ZRAM
sleep 3
DISKSIZEDEF=`cat /sys$ZRAM/disksize`
DISKSIZE=
#%MemTotalStr=`cat /proc/meminfo | grep MemTotal`
#%MemTotal=${MemTotalStr:16:8}
#%let VALUE="$MemTotal * VAR / 100"
#%DISKSIZE=$VALUE\K
sleep 3
swapoff /dev$ZRAM
echo 1 > /sys$ZRAM/reset
sleep 3
ALGODEF=`cat /sys$ZRAM/comp_algorithm`
ALGO=
[ "$ALGO" ] && echo "$ALGO" > /sys$ZRAM/comp_algorithm
#oecho "$DISKSIZE" > /sys$ZRAM/disksize
#omkswap /dev$ZRAM
sleep 3
PRIO=
#o/system/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /system/vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| swapon /dev$ZRAM

# Android Device/Kernel Settings/Parameters Modifications
sleep 3
[ -f "$MODPATH/system_settings.sh" ] && sh "$MODPATH/system_settings.sh"
sleep 3
[ -f "$MODPATH/system_governors.sh" ] && sh "$MODPATH/system_governors.sh"
sleep 3
[ -f "$MODPATH/system_kernel.sh" ] && sh "$MODPATH/system_kernel.sh"
sleep 3
[ -f "$MODPATH/system_cpu_gpu_power.sh" ] && sh "$MODPATH/system_cpu_gpu_power.sh"

# System Files Permissions
sleep 3
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi

# Do Apply-On-Pre/Post-Boot again in case the first attempt were unsuccessful.
sleep 3
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi
sleep 3
if [ -x "$(command -v resetprop)" ]; then
    resetprop -n ro.boot.selinux enforcing
    if [ -n "$(resetprop ro.build.selinux)" ]; then
        resetprop --delete ro.build.selinux
    fi
fi
sleep 3
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi
sleep 3
[ -f "$MODPATH/system_settings.sh" ] && sh "$MODPATH/system_settings.sh"
sleep 3
[ -f "$MODPATH/system_governors.sh" ] && sh "$MODPATH/system_governors.sh"
sleep 3
[ -f "$MODPATH/system_kernel.sh" ] && sh "$MODPATH/system_kernel.sh"
sleep 3
[ -f "$MODPATH/system_cpu_gpu_power.sh" ] && sh "$MODPATH/system_cpu_gpu_power.sh"
sleep 3
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi