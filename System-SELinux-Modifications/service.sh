#!/system/bin/sh
# Initialize variables at once
MODPATH="${0%/*}"
MODDIR="${0%/*}"

# System Files Permissions
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi

# OS System SELinux and ADB Root Modifications
if [ -f "$MODPATH/system_selinux.sh" ]; then
    sh "$MODPATH/system_selinux.sh"
fi
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

# System Files Permissions
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi

# Do Apply-On-Pre/Post-Boot again in case the first attempt were unsuccessful.
if [ -f "$MODPATH/system_files_chmods-1.sh" ]; then
    sh "$MODPATH/system_files_chmods-1.sh"
fi
if [ -f "$MODPATH/system_selinux.sh" ]; then
    sh "$MODPATH/system_selinux.sh"
fi
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
if [ -f "$MODPATH/system_files_chmods-2.sh" ]; then
    sh "$MODPATH/system_files_chmods-2.sh"
fi