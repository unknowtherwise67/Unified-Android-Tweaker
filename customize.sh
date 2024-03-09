#!/system/bin/sh
SCRIPT_PARENT_PATH="$MODPATH/system/bin"
SCRIPT_NAME="ktweak"
SCRIPT_PATH="$SCRIPT_PARENT_PATH/$SCRIPT_NAME"

ui_print " * Setting executable permissions..."
set_perm_recursive "$SCRIPT_PATH" root root 0777 0755

ui_print " * Executing script immediately..."
ui_print ""
sh "$SCRIPT_PATH"

ui_print ""
ui_print " * The next section will be start excecuting..."
ui_print " * Setting executable permissions..."
ui_print " * Executing script..."
ui_print ""

SKIPUNZIP=0
## Variables
#
# MAGISK_VER (string): the version string of current installed Magisk (e.g. v20.0)
# MAGISK_VER_CODE (int): the version code of current installed Magisk (e.g. 20000)
# BOOTMODE (bool): true if the module is being installed in Magisk Manager
# MODPATH (path): the path where your module files should be installed
# TMPDIR (path): a place where you can temporarily store files
# ZIPFILE (path): your module’s installation zip
# ARCH (string): the CPU architecture of the device. Value is either arm, arm64, x86, or x64
# IS64BIT (bool): true if $ARCH is either arm64 or x64
# API (int): the API level (Android version) of the device (e.g. 21 for Android 5.0)
# 

## Function
# ui_print <msg>
#   print <msg> to console
#   Avoid using 'echo' as it will not display in custom recovery's console
# abort <msg>
#   print error message <msg> to console and terminate installation
#   Avoid using 'exit' as it will skip the termination cleanup steps
# set_perm <target> <owner> <group> <permission> [context]
#   if [context] is not set, the default is "u:object_r:system_file:s0"
#   this function is a shorthand for the following commands:
#      chown owner.group target
#      chmod permission target
#      chcon context target
# set_perm_recursive <directory> <owner> <group> <dirpermission> <filepermission> [context]
#   if [context] is not set, the default is "u:object_r:system_file:s0"
#   for all files in <directory>, it will call:
#      set_perm file owner group filepermission context
#   for all directories in <directory> (including itself), it will call:
#      set_perm dir owner group dirpermission context

### fix module command
bin=xbin
if [ ! -d system/xbin ]; then
    bin=bin
    mkdir $MODPATH/system/$bin
    mv $MODPATH/system/xbin/* $MODPATH/system/$bin
    rm -rf $MODPATH/system/xbin/*
    rmdir $MODPATH/system/xbin
fi
function FindThermal(){
    for systemThermal in `ls $1 | grep $2`
    do
        if [[ "$systemThermal" == *"-BlankFile"* ]]; then
            ui_print "ignoring conflict file : $1/$systemThermal"
        elif [[ "$systemThermal" == *"-OriFile.bck"* ]]; then
            ui_print "ignoring conflict file : $1/$systemThermal"
        else
            ui_print "found $1/$systemThermal"
            if [ $2 == "thermal" ];then
                if [ ! -f "$3/$systemThermal-BlankFile" ] ; then
                    echo "" > "$3/$systemThermal-BlankFile"
                fi
                if [ ! -f "$3/$systemThermal-OriFile.bck" ] ; then
                    cp -af "$1/$systemThermal" "$3/$systemThermal-OriFile.bck"
                fi
                cp -af "$3/$systemThermal-BlankFile" "$3/$systemThermal"
            else
                if [ ! -f "$3/$systemThermal" ] ; then
                    cp -af "$1/$systemThermal" "$3/$systemThermal"
                fi
            fi
        fi
    done
}
FindThermal "/system/bin" '"-OriFile.bck"' "$MODPATH/system/bin"
FindThermal "/system/bin" 'thermal' "$MODPATH/system/bin"
FindThermal "/vendor/bin" '"-OriFile.bck"' "$MODPATH/system/vendor/bin"
FindThermal "/vendor/bin" 'thermal' "$MODPATH/system/vendor/bin"
FindThermal "/vendor/etc" '"-OriFile.bck"' "$MODPATH/system/vendor/etc"
FindThermal "/vendor/etc" 'thermal' "$MODPATH/system/vendor/etc"
echo "0" > "$MODPATH/system/vendor/etc/thermalStatus.info"

### fix folder permission
set_perm_recursive $MODPATH                   0 0 0755 0777
set_perm_recursive $MODPATH/system/$bin       0 0 0755 0777
if [ $bin == "xbin" ]; then
    set_perm_recursive $MODPATH/system/bin       0 0 0755 0777
fi
set_perm_recursive $MODPATH/system/vendor/bin       0 0 0755 0777
set_perm_recursive $MODPATH/system/vendor/etc       0 0 0755 0644
set_perm_recursive $MODPATH/system/etc/zyc_tk 0 0 0755 0777

echo "$NVBASE/modules" > /data/magisk_path.txt

ui_print ""
ui_print " * The next section will be start excecuting..."
ui_print " * Executing script..."
ui_print ""

# space
ui_print " "

# var
UID=`id -u`

# log
if [ "$BOOTMODE" != true ]; then
  FILE=/data/media/"$UID"/$MODID\_recovery.log
  ui_print "- Log will be saved at $FILE"
  exec 2>$FILE
  ui_print " "
fi

# optionals
OPTIONALS=$MODPATH/optionals.prop
if [ ! -f $OPTIONALS ]; then
  touch $OPTIONALS
fi

# debug
if [ "`grep_prop debug.log $OPTIONALS`" == 1 ]; then
  ui_print "- The install log will contain detailed information"
  set -x
  ui_print " "
fi

# run
. $MODPATH/function.sh

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
if [ "$KSU" == true ]; then
  ui_print " KSUVersion=$KSU_VER"
  ui_print " KSUVersionCode=$KSU_VER_CODE"
  ui_print " KSUKernelVersionCode=$KSU_KERNEL_VER_CODE"
  sed -i 's|#k||g' $MODPATH/post-fs-data.sh
else
  ui_print " MagiskVersion=$MAGISK_VER"
  ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
fi
ui_print " "

# sepolicy
FILE=$MODPATH/sepolicy.rule
DES=$MODPATH/sepolicy.pfsd
if [ "`grep_prop sepolicy.sh $OPTIONALS`" == 1 ]\
&& [ -f $FILE ]; then
  mv -f $FILE $DES
fi

# cleaning
ui_print "- Cleaning..."
remove_sepolicy_rule
ui_print " "

# zram
PROP=`grep_prop zram.resize $OPTIONALS`
if [ "$PROP" == 0 ]; then
  ui_print "- ZRAM Swap will be disabled"
  ui_print " "
  LMK=false
else
  FILE=/sys/block/zram0/disksize
  ui_print "- Changes $FILE"
  sed -i 's|#o||g' $MODPATH/service.sh
  if echo "$PROP" | grep -q %; then
    ui_print "  to $PROP of RAM size"
    PROP=`echo "$PROP" | sed 's|%||g'`
    sed -i "s|VAR|$PROP|g" $MODPATH/service.sh
    sed -i 's|#%||g' $MODPATH/service.sh
  elif [ "$PROP" ]; then
    ui_print "  to $PROP Byte"
    sed -i "s|ZRAM=100|ZRAM=$PROP|g" $MODPATH/service.sh
  else
    ui_print "  to 100% of RAM size"
  fi
  ui_print " "
  PROP=`grep_prop zram.algo $OPTIONALS`
  if [ "$PROP" ]; then
    FILE=/sys/block/zram0/comp_algorithm
    if grep -q "$PROP" $FILE; then
      ui_print "- Changes $FILE"
      ui_print "  to $PROP"
      sed -i "s|#ALGO=|ALGO=$PROP|g" $MODPATH/service.sh
    else
      ui_print "! $PROP is unsupported"
      ui_print "  in $FILE"
    fi
    ui_print " "
  fi
  if [ "`grep_prop zram.lmk $OPTIONALS`" == 0 ]; then
    LMK=false
  else
    LMK=true
  fi
fi

# lmk
if [ $LMK == true ]; then
  sed -i 's|#L||g' $MODPATH/service.sh
else
  ui_print "- Does not use LMK configs"
  ui_print " "
fi

## print word
ui_print ""
ui_print " * Module installed and executing scripts completed."
ui_print " * ZRAM is configured and will be in effects after reboot."
ui_print " * You need to reboot the device to take effects."
ui_print ""
ui_print " * ADDITIONAL NOTES:"
ui_print " * NOTE THAT USE THIS MODULE AT YOUR OWN RISKS"
ui_print " * DEVELOPERS OF THIS MODULE ARE NOT TOOK RESPONSIBILITY FOR ANYHING THAT HAPPENS."
ui_print " * See README, known issues and reported issues on Github."
ui_print " * Source codes is available on GitHub, you can find it in there."
ui_print " * Credits to tytydraco, reiryuki, erenyeagarr, topjohnwu, tiann and osm0sis."
ui_print ""