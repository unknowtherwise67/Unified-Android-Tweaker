#!/system/bin/sh
# Initialize variables at once
MODPATH="${0%/*}"
MODDIR="${0%/*}"

# Timeout until Apply-On-Pre/Post-Boot actions
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 60
done

# System Files Permissions
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi

# Android Device/Kernel Settings/Parameters Modifications
[ -f "$MODPATH/system_settings.sh" ] && sh "$MODPATH/system_settings.sh"
[ -f "$MODPATH/system_governors.sh" ] && sh "$MODPATH/system_governors.sh"
[ -f "$MODPATH/system_kernel.sh" ] && sh "$MODPATH/system_kernel.sh"
[ -f "$MODPATH/system_cpu_gpu_power.sh" ] && sh "$MODPATH/system_cpu_gpu_power.sh"

# System Files Permissions
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi

# Android Device/Kernel ZRAM Swap Virtual Memory Modifications
ZRAM=/block/zram0
DISKSIZEDEF=`cat /sys$ZRAM/disksize`
DISKSIZE=
#%MemTotal=`awk '/MemTotal/ {print $2}' /proc/meminfo`
#%let VALUE="$MemTotal * VAR / 100"
#%DISKSIZE=$VALUE\K
SWAPOFF=false
if grep -q /dev$ZRAM /proc/swaps; then
  for i in `seq 1 20`; do
    if swapoff /dev$ZRAM; then
      SWAPOFF=true
      break
    fi
  done
  if grep -q /dev$ZRAM /proc/swaps; then
    SWAPOFF=false
  fi
else
  SWAPOFF=true
fi
ALGODEF=`cat /sys$ZRAM/comp_algorithm`
ALGO=
PRIODEF=`cat /proc/swaps | awk 'NR>1 {print $5}'`
PRIO=
if $SWAPOFF; then
  echo 1 > /sys$ZRAM/reset
  [ "$ALGO" ] && echo "$ALGO" > /sys$ZRAM/comp_algorithm
#o  echo "$DISKSIZE" > /sys$ZRAM/disksize
#o  mkswap /dev$ZRAM
#o  /system/bin/swapon /dev$ZRAM -p "$PRIO"\
#o  || /vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o  || /system/vendor/bin/swapon /dev$ZRAM -p "$PRIO"\
#o  || swapon /dev$ZRAM
fi

# OS System ResetProps
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
chmod 640 /sys/fs/selinux/enforce
if [ -x "\$(command -v resetprop)" ]
then
	resetprop -n ro.boot.selinux enforcing
fi
if [ -x "\$(command -v resetprop)" ] && [ -n "\$(resetprop ro.build.selinux)" ]
then
	resetprop --delete ro.build.selinux
fi
resetprop -n -p init.svc.adb_root ""
adbroot="$(getprop service.adb.root)"
if [ -n "$adbroot" ]; then
    resetprop -n -p service.adb.root ""
fi

# Android Device/Kernel Settings/Parameters Modifications
sleep 5
settings put global airplane_mode_on 1
am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true

# Android Device/Kernel Settings/Parameters Modifications
sleep 5
settings put global airplane_mode_on 0
am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false