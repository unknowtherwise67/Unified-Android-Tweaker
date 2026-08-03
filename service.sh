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
if [ "$(getprop sys.init.perf_lsm)" = "basic" ] || [ "$(getprop init.svc.goldfish-logcat)" = "running" ]; then
    exit 0
fi
# All Mods/Tweaks/Others parameters will be modified/applied after this configured time parameter are elapsed
sleep 1

# System Files Permissions.
sleep 1
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi

# OS System ResetProps
sleep 1
if [ -x "$(command -v resetprop)" ]; then
    change_prop() {
        local prop="$1"
        local val="$2"
        if [ "$(resetprop "$prop" 2>/dev/null)" != "$val" ]; then
            case "$prop" in
                ro.*|vendor.*) resetprop -n "$prop" "$val" ;;
                *) resetprop "$prop" "$val" ;;
            esac
        fi
    }
    delete_prop() {
        local prop="$1"
        if [ -n "$(resetprop "$prop" 2>/dev/null)" ]; then
            resetprop --delete "$prop"
        fi
    }
    change_prop ro.boot.selinux "enforcing"
    change_prop ro.boot.veritymode "enforcing"
    change_prop init.svc.adb_root "stopped"
    change_prop service.adb.root "0"
    change_prop ro.adb.secure "1"
    change_prop ro.build.tags "release-keys"
    change_prop ro.build.type "user"
    change_prop ro.debuggable "0"
    change_prop ro.secure "1"
    change_prop sys.oem_unlock_allowed "0"
    change_prop ro.boot.flash.locked "1"
    change_prop ro.secureboot.lockstate "locked"
    change_prop ro.boot.realme.lockstate "1"
    change_prop ro.boot.vbmeta.device_state "locked"
    change_prop vendor.boot.vbmeta.device_state "locked"
    change_prop ro.boot.verifiedbootstate "green"
    change_prop vendor.boot.verifiedbootstate "green"
    change_prop ro.boot.warranty_bit "0"
    change_prop ro.warranty_bit "0"
    delete_prop ro.build.selinux
fi
sleep 1
chmod 640 /sys/fs/selinux/enforce
if [ -x "\$(command -v resetprop)" ]
then
	resetprop -n ro.boot.selinux enforcing
fi
if [ -x "\$(command -v resetprop)" ] && [ -n "\$(resetprop ro.build.selinux)" ]
then
	resetprop --delete ro.build.selinux
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
sleep 3
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi
sleep 1
if [ -x "$(command -v resetprop)" ]; then
    change_prop() {
        local prop="$1"
        local val="$2"
        if [ "$(resetprop "$prop" 2>/dev/null)" != "$val" ]; then
            case "$prop" in
                ro.*|vendor.*) resetprop -n "$prop" "$val" ;;
                *) resetprop "$prop" "$val" ;;
            esac
        fi
    }
    delete_prop() {
        local prop="$1"
        if [ -n "$(resetprop "$prop" 2>/dev/null)" ]; then
            resetprop --delete "$prop"
        fi
    }
    change_prop ro.boot.selinux "enforcing"
    change_prop ro.boot.veritymode "enforcing"
    change_prop init.svc.adb_root "stopped"
    change_prop service.adb.root "0"
    change_prop ro.adb.secure "1"
    change_prop ro.build.tags "release-keys"
    change_prop ro.build.type "user"
    change_prop ro.debuggable "0"
    change_prop ro.secure "1"
    change_prop sys.oem_unlock_allowed "0"
    change_prop ro.boot.flash.locked "1"
    change_prop ro.secureboot.lockstate "locked"
    change_prop ro.boot.realme.lockstate "1"
    change_prop ro.boot.vbmeta.device_state "locked"
    change_prop vendor.boot.vbmeta.device_state "locked"
    change_prop ro.boot.verifiedbootstate "green"
    change_prop vendor.boot.verifiedbootstate "green"
    change_prop ro.boot.warranty_bit "0"
    change_prop ro.warranty_bit "0"
    delete_prop ro.build.selinux
fi
sleep 1
chmod 640 /sys/fs/selinux/enforce
if [ -x "\$(command -v resetprop)" ]
then
	resetprop -n ro.boot.selinux enforcing
fi
if [ -x "\$(command -v resetprop)" ] && [ -n "\$(resetprop ro.build.selinux)" ]
then
	resetprop --delete ro.build.selinux
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