# Log the date and time
echo "- Time of execution: $(date)"

# Premission
ui_print "- Setting Premission..."
set_perm_recursive $MODPATH 0 2000 0755 0777
set_perm_recursive $MODPATH/system 0 2000 0755 0777 u:object_r:system_file:s0
set_perm_recursive $MODPATH/system/bin 0 2000 0755 0777 u:object_r:system_configs_file:s0
set_perm_recursive $MODPATH/system/odm 0 2000 0755 0777 u:object_r:system_configs_file:s0
set_perm_recursive $MODPATH/system/etc 0 2000 0755 0777 u:object_r:system_configs_file:s0
set_perm_recursive $MODPATH/system/odm/etc 0 2000 0755 0777 u:object_r:system_configs_file:s0
set_perm_recursive $MODPATH/system/etc/audio 0 2000 0755 0777 u:object_r:system_configs_file:s0
set_perm_recursive $MODPATH/system/vendor 0 2000 0755 0777 u:object_r:vendor_file:s0
set_perm_recursive $MODPATH/system/vendor/bin 0 2000 0755 0777 u:object_r:vendor_configs_file:s0
set_perm_recursive $MODPATH/system/vendor/etc 0 2000 0755 0777 u:object_r:vendor_configs_file:s0
set_perm_recursive $MODPATH/system/vendor/odm 0 2000 0755 0777 u:object_r:vendor_configs_file:s0
set_perm_recursive $MODPATH/system/vendor/etc/audio 0 2000 0755 0777 u:object_r:vendor_configs_file:s0
set_perm_recursive $MODPATH/system/vendor/odm/etc 0 2000 0755 0777 u:object_r:vendor_configs_file:s0
set_perm_recursive $MODPATH/x86 0 2000 0755 0777
set_perm_recursive $MODPATH/x86_64 0 2000 0755 0777
set_perm_recursive $MODPATH/armeabi-v7a 0 2000 0755 0777
set_perm_recursive $MODPATH/arm64-v8a 0 2000 0755 0777
ui_print "- Setting Premission Completed."

# Kernel Tweaks
ui_print "- Executing script immediately..."
sh $MODPATH/tweaker.sh

ui_print ""
ui_print "- DONE."
ui_print "- The next section will be start excecuting."
ui_print "- Executing..."
ui_print ""

# ZRAM Virtual Memory
ZRAM=$MODPATH/zram.sh
if [ ! -f $OPTIONALS ]; then
  touch $ZRAM
fi

. $MODPATH/function.sh

FILE=$MODPATH/sepolicy.rule
DES=$MODPATH/sepolicy.pfsd
if [ "`grep_prop sepolicy.sh $ZRAM`" == 1 ]\
&& [ -f $FILE ]; then
  mv -f $FILE $DES
fi

ui_print "- Cleaning..."
remove_sepolicy_rule
ui_print ""

PROP=`grep_prop zram.resize $ZRAM`
if [ "$PROP" == 0 ]; then
  ui_print "- ZRAM Swap will be disabled"
  ui_print ""
  LMK=false
else
  FILE=/sys/block/zram0/disksize
  ui_print "- Modifying $FILE"
  sed -i 's|#o||g' $MODPATH/service.sh
  if echo "$PROP" | grep -q %; then
    ui_print "- To $PROP of RAM size"
    PROP=`echo "$PROP" | sed 's|%||g'`
    sed -i "s|VAR|$PROP|g" $MODPATH/service.sh
    sed -i 's|#%||g' $MODPATH/service.sh
  elif [ "$PROP" ]; then
    ui_print "- To $PROP Byte"
    sed -i "s|ZRAM=3G|ZRAM=$PROP|g" $MODPATH/service.sh
  else
    ui_print "- To 3GBs"
  fi
  ui_print ""
  PROP=`grep_prop zram.algo $ZRAM`
  if [ "$PROP" ]; then
    FILE=/sys/block/zram0/comp_algorithm
    if grep -q "$PROP" $FILE; then
      ui_print "- Modifying $FILE"
      ui_print "- To $PROP"
      sed -i "s|#ALGO=|ALGO=$PROP|g" $MODPATH/service.sh
    else
      ui_print "! $PROP is unsupported"
      ui_print "- in $FILE"
    fi
    ui_print ""
  fi
fi

# Audio Modifcation Library
AUDIO=$MODPATH/audio_modification1.sh
if [ ! -f $AUDIO ]; then
  touch $AUDIO
fi

ui_print "- Modules detection and patching happens at boot."
ui_print "- The boot script handles everything."
ui_print "- Disabled modules will be ignored."
ui_print " "

sed -i -e 's/\\/\\\\/g' -e 's/\ /\\ /g' $MODPATH/AudioModificationLibrary.sh
mkdir $MODPATH/.scripts
while read line; do
  case $line in
    \#*) if [ "$uuid" ]; then
           echo " " >> $MODPATH/.scripts/$uuid.sh
         fi
         uuid=$(echo "$line" | sed "s/#//g");;
    *) echo "$line" >> $MODPATH/.scripts/$uuid.sh;;
  esac
done < $MODPATH/AudioModificationLibrary.sh
rm -f $MODPATH/AudioModificationLibrary.sh
for i in $MODPATH/.scripts/*; do
  libs="$libs-name \"$(basename $i | sed "s/~.*//g")\" "
done
libs="$(echo $libs | sed "s/\" /\" -o /g")"
sed -i -e "s|<libs>|$libs|g" $MODPATH/service.sh

[ -z $SERVICED ] && SERVICED=$NVBASE/service.d
amldir=$NVBASE/aml
for i in amldir; do
  for j in post-fs-data service uninstall; do
    sed -i "s|$i=|$i=$(eval echo \$$i)|g" $MODPATH/$j.sh
  done
done

ui_print ""
ui_print "- DONE."
ui_print "- The next section will be start excecuting."
ui_print "- Executing..."
ui_print ""

# AudioFX Modification
AUDIO=$MODPATH/audio_modification2.sh
if [ ! -f $AUDIO ]; then
  touch $AUDIO
fi

. $MODPATH/function.sh

mount_partitions_in_recovery

magisk_setup

SYSTEM=`realpath $MIRROR/system`
VENDOR=`realpath $MIRROR/vendor`
PRODUCT=`realpath $MIRROR/product`
SYSTEM_EXT=`realpath $MIRROR/system_ext`
ODM=`realpath $MIRROR/odm`
MY_PRODUCT=`realpath $MIRROR/my_product`

FILE=$MODPATH/sepolicy.rule
DES=$MODPATH/sepolicy.pfsd
if [ "`grep_prop sepolicy.sh $OPTIONALS`" == 1 ]\
&& [ -f $FILE ]; then
  mv -f $FILE $DES
fi

mv -f $MODPATH/aml.sh $MODPATH/.aml.sh

ui_print "- Cleaning..."
remove_sepolicy_rule
ui_print ""

hide_oat() {
for APP in $APPS; do
  REPLACE="$REPLACE
  `find $MODPATH/system -type d -name $APP | sed "s|$MODPATH||g"`/oat"
done
}
replace_dir() {
if [ -d $DIR ]; then
  REPLACE="$REPLACE $MODDIR"
fi
}
hide_app() {
for APP in $APPS; do
  DIR=$SYSTEM/app/$APP
  MODDIR=/system/app/$APP
  replace_dir
  DIR=$SYSTEM/priv-app/$APP
  MODDIR=/system/priv-app/$APP
  replace_dir
  DIR=$PRODUCT/app/$APP
  MODDIR=/system/product/app/$APP
  replace_dir
  DIR=$PRODUCT/priv-app/$APP
  MODDIR=/system/product/priv-app/$APP
  replace_dir
  DIR=$MY_PRODUCT/app/$APP
  MODDIR=/system/product/app/$APP
  replace_dir
  DIR=$MY_PRODUCT/priv-app/$APP
  MODDIR=/system/product/priv-app/$APP
  replace_dir
  DIR=$PRODUCT/preinstall/$APP
  MODDIR=/system/product/preinstall/$APP
  replace_dir
  DIR=$SYSTEM_EXT/app/$APP
  MODDIR=/system/system_ext/app/$APP
  replace_dir
  DIR=$SYSTEM_EXT/priv-app/$APP
  MODDIR=/system/system_ext/priv-app/$APP
  replace_dir
  DIR=$VENDOR/app/$APP
  MODDIR=/system/vendor/app/$APP
  replace_dir
  DIR=$VENDOR/euclid/product/app/$APP
  MODDIR=/system/vendor/euclid/product/app/$APP
  replace_dir
done
}

APPS="AudioFX MusicFX"
hide_app

. $MODPATH/copy.sh
. $MODPATH/.aml.sh

unmount_mirror

ui_print "- DONE."

# Print Word
ui_print ""
ui_print "- Module installed and executing scripts completed."
ui_print "- You are required to REBOOT the device to take effects."
ui_print ""
ui_print "- ADDITIONAL NOTES:"
ui_print "- NOTE THAT USE THIS MODULE AT YOUR OWN RISKS"
ui_print "- DEVELOPERS OF THIS MODULE ARE NOT TOOK RESPONSIBILITY FOR ANYHING THAT HAPPENS."
ui_print "- See README, known issues and reported issues on Github."
ui_print "- Source codes is available on GitHub."
ui_print "- Credits is in README."
ui_print ""