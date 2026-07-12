#!/system/bin/sh
# Initialize variables at once
MODPATH="${0%/*}"
MODDIR="${0%/*}"

# Apply-On-Pre/Post-Boot section
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
sleep 1
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi

# OS System SELinux and ADB Root Modifications
sleep 1
if [ -f "$MODPATH/system_selinux.sh" ]; then
    sh "$MODPATH/system_selinux.sh"
fi
sleep 1
if [ -x "$(command -v resetprop)" ]; then
    resetprop -n ro.boot.selinux enforcing
    if [ -n "$(resetprop ro.build.selinux)" ]; then
        resetprop --delete ro.build.selinux
    fi
fi
sleep 1
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi

# Android Device/Kernel ZRAM Swap Virtual Memory Modifications
sleep 1
ZRAM=/block/zram0
swapoff /dev$ZRAM
sleep 1
DISKSIZEDEF=`cat /sys$ZRAM/disksize`
DISKSIZE=
#%MemTotalStr=`cat /proc/meminfo | grep MemTotal`
#%MemTotal=${MemTotalStr:16:8}
#%let VALUE="$MemTotal * VAR / 100"
#%DISKSIZE=$VALUE\K
sleep 1
swapoff /dev$ZRAM
echo 1 > /sys$ZRAM/reset
sleep 1
ALGODEF=`cat /sys$ZRAM/comp_algorithm`
ALGO=
[ "$ALGO" ] && echo "$ALGO" > /sys$ZRAM/comp_algorithm
#oecho "$DISKSIZE" > /sys$ZRAM/disksize
#omkswap /dev$ZRAM
sleep 1
PRIO=
#o/system/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| /system/vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o|| swapon /dev$ZRAM

# Android Device/Kernel Settings/Parameters Modifications
sleep 1
[ -f "$MODPATH/system_settings.sh" ] && sh "$MODPATH/system_settings.sh"
sleep 1
[ -f "$MODPATH/system_governors.sh" ] && sh "$MODPATH/system_governors.sh"
sleep 1
[ -f "$MODPATH/system_kernel.sh" ] && sh "$MODPATH/system_kernel.sh"
sleep 1
[ -f "$MODPATH/system_cpu_gpu_power.sh" ] && sh "$MODPATH/system_cpu_gpu_power.sh"

# System Files Permissions
sleep 1
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi

# Do Apply-On-Pre/Post-Boot again in case the first attempt were unsuccessful.
sleep 1
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi
sleep 1
if [ -f "$MODPATH/system_selinux.sh" ]; then
    sh "$MODPATH/system_selinux.sh"
fi
sleep 1
if [ -x "$(command -v resetprop)" ]; then
    resetprop -n ro.boot.selinux enforcing
    if [ -n "$(resetprop ro.build.selinux)" ]; then
        resetprop --delete ro.build.selinux
    fi
fi
sleep 1
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi
sleep 1
[ -f "$MODPATH/system_settings.sh" ] && sh "$MODPATH/system_settings.sh"
sleep 1
[ -f "$MODPATH/system_governors.sh" ] && sh "$MODPATH/system_governors.sh"
sleep 1
[ -f "$MODPATH/system_kernel.sh" ] && sh "$MODPATH/system_kernel.sh"
sleep 1
[ -f "$MODPATH/system_cpu_gpu_power.sh" ] && sh "$MODPATH/system_cpu_gpu_power.sh"
sleep 1
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi