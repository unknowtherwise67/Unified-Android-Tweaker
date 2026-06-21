# System Files Permissions
MODPATH=${0%/*}
MODDIR=${0%/*}
sh $MODPATH/system_files_chmods-1.sh

# Device and System SELinux Modifications
MODPATH=${0%/*}
MODDIR=${0%/*}
sh $MODPATH/system_selinux.sh
if [ -x "\$(command -v resetprop)" ]
then
	resetprop -n ro.boot.selinux enforcing
fi
if [ -x "\$(command -v resetprop)" ] && [ -n "\$(resetprop ro.build.selinux)" ]
then
	resetprop --delete ro.build.selinux
fi

# System Files Permissions
MODPATH=${0%/*}
MODDIR=${0%/*}
sh $MODPATH/system_files_chmods-2.sh