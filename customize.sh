# Log the date and time
echo "- Time of execution: $(date)"

# Premission
ui_print "- Setting Premission..."
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/system 0 0 0755 0644
set_perm_recursive $MODPATH/system/bin 0 0 0755 0644
set_perm_recursive $MODPATH/system/etc 0 0 0755 0644
set_perm_recursive $MODPATH/system/odm 0 0 0755 0644
set_perm_recursive $MODPATH/system/odm/etc 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/bin 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/etc 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/odm 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/odm/etc 0 0 0755 0644
set_perm_recursive $MODPATH/x86 0 0 0755 0644
set_perm_recursive $MODPATH/x86_64 0 0 0755 0644
set_perm_recursive $MODPATH/armeabi-v7a 0 0 0755 0644
set_perm_recursive $MODPATH/arm64-v8a 0 0 0755 0644
set_perm_recursive $MODPATH/libs 0 0 0755 0644
set_perm_recursive $MODPATH/libs/x86 0 0 0755 0644
set_perm_recursive $MODPATH/libs/x86_64 0 0 0755 0644
set_perm_recursive $MODPATH/libs/armeabi-v7a 0 0 0755 0644
set_perm_recursive $MODPATH/libs/arm64-v8a 0 0 0755 0644
ui_print "- Setting Premission Completed."

# Scripts Executes
ui_print ""
ui_print "- It will take some time."
ui_print "- Please wait until is completed."
ui_print "- Executing Scripts..."

# Kernel Tweaks
ui_print ""
ui_print "- Fine-Tunning Android System/User/Kernel settings and parameters..."
sh $MODPATH/tweaker.sh

# Zygisk MapHide
ui_print ""
mkdir -p "$MODPATH/zygisk"
api_level_arch_detect
[ ! -d "$MODPATH/libs/$ABI" ] && abort "Error - $ABI is not supported"
ui_print "- Extracting Zygisk module..."
cp -af "$MODPATH/libs/$ABI/libzygisk_module.so" "$MODPATH/zygisk/$ABI.so"
cp -af "$MODPATH/libs/$ABI32/libzygisk_module.so" "$MODPATH/zygisk/$ABI32.so"
rm -rf "$MODPATH/libs"
ui_print "- Completed."

# ZRAM Virtual Memory
ui_print ""
ZRAM=$MODPATH/zram.sh
if [ ! -f $ZRAM ]; then
  touch $ZRAM
fi

sh $MODPATH/function.sh

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
    sed -i "s|ZRAM=1G|ZRAM=$PROP|g" $MODPATH/service.sh
  else
    ui_print "- To 1GBs"
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
      ui_print "! $PROP is UNSUPPORTED"
      ui_print "- in $FILE"
    fi
    ui_print ""
  fi
fi

ui_print "- DONE."

ui_print ""
ui_print "- Module installed and executing scripts completed."
ui_print "- You are required to REBOOT the device to take effects."
ui_print ""
ui_print "- ADDITIONAL NOTES:"
ui_print "- NOTE THAT USE THIS MODULE AT YOUR OWN RISKS"
ui_print "- DEVELOPERS OF THIS MODULE ARE NOT TOOK RESPONSIBILITY FOR ANYHING THAT HAPPENS."
ui_print "- README, Sources Codes, Credits, known/reported issues are on GitHub."
ui_print ""