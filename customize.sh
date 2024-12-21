# Log the date and time
echo "- Time of execution: $(date)"

# Premission
ui_print ""
ui_print "- Installing Files and Setting Premission..."
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/system 0 0 0755 0644
set_perm_recursive $MODPATH/system/bin 0 0 0755 0644
set_perm_recursive $MODPATH/system/etc 0 0 0755 0644
set_perm_recursive $MODPATH/system/odm 0 0 0755 0644
set_perm_recursive $MODPATH/system/odm/etc 0 0 0755 0644
set_perm_recursive $MODPATH/system/bin/modules 0 0 0755 0644
set_perm_recursive $MODPATH/system/etc/thermal 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/bin 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/etc 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/odm 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/odm/etc 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/bin/modules 0 0 0755 0644
set_perm_recursive $MODPATH/system/vendor/etc/thermal 0 0 0755 0644
ui_print "- Installing Files and Setting Premission Completed."

# Scripts Executes
ui_print ""
ui_print "- It will take some time."
ui_print "- Please wait and be patience until is completed."
ui_print "- Executing Root Module Files..."

# Kernel Tweaks
ui_print ""
ui_print "- Fine-Tunning Android System/User/Kernel Settings, Tunables and Parameters..."
sh $MODPATH/device_settings.sh
sh $MODPATH/system_governors.sh
sh $MODPATH/system_kernel.sh
ui_print "- Completed."

# ZRAM/Swap Virtual Memory
ui_print ""
ZRAM=$MODPATH/virtual_memory.sh
if [ ! -f $ZRAM ]; then
  touch $ZRAM
fi

PROP=`grep_prop zram.resize $ZRAM`
ZRAM=/block/zram0
if [ "$PROP" == 0 ]; then
  ui_print "- ZRAM/Swap Virtual Memory will be Disabled."
  LMK=false
else
  FILE=/sys$ZRAM/disksize
  ui_print "- Modifying $FILE..."
  sed -i 's|#o||g' $MODPATH/service.sh
  if echo "$PROP" | grep -q %; then
    ui_print "- To $PROP of Physical RAM Size..."
    PROP=`echo "$PROP" | sed 's|%||g'`
    sed -i "s|VAR|$PROP|g" $MODPATH/service.sh
    sed -i 's|#%||g' $MODPATH/service.sh
  elif [ "$PROP" ]; then
    ui_print "- To $PROP of Physical RAM Size..."
    sed -i "s|DISKSIZE=1G|DISKSIZE=$PROP|g" $MODPATH/service.sh
  else
    ui_print "- To 1GBs of Physical RAM Size..."
  fi
  PROP=`grep_prop zram.algo $ZRAM`
  if [ "$PROP" ]; then
    FILE=/sys$ZRAM/comp_algorithm
    if grep -q "$PROP" $FILE; then
      ui_print "- Modifying $FILE..."
      ui_print "- To $PROP..."
      sed -i "s|ALGO=|ALGO=$PROP|g" $MODPATH/service.sh
    else
      ui_print "! $PROP is Unsupported"
      ui_print "  in $FILE"
    fi
  fi
  PROP=`grep_prop zram.prio $ZRAM`
  if [ "$PROP" ]; then
    ui_print "- Modifying Swap Priority $PROP..."
    sed -i "s|PRIO=0|PRIO=$PROP|g" $MODPATH/service.sh
  else
    ui_print "- Modifying Swap Priority to 0..."
    ui_print "- To 0..."
  fi
fi

PROP=`grep_prop zram.sflp $ZRAM`
if [ "$PROP" ]; then
  if [ "$PROP" -gt 100 ]; then
    PROP=100
  elif [ "$PROP" -lt 0 ]; then
    unset PROP
  fi
fi
if [ "$PROP" ]; then
  ui_print "- Modifying swap_free_low_percentage..."
  ui_print "- To $PROP"
  sed -i "s|SFLP=0|SFLP=$PROP|g" $MODPATH/service.sh
else
  ui_print "- Modifying swap_free_low_percentage..."
  ui_print "- To 0..."
  ui_print "- Completed."
  ui_print ""
fi

ui_print "- Scripts executions completed, Root Module is installed."
ui_print "- It's may recommended to REBOOT the Device."
ui_print ""
ui_print "- ADDITIONAL NOTES:"
ui_print "- INSTALL AND USE THIS ROOT MODULE AT YOUR OWN RISKS."
ui_print "- DEVELOPERS ARE DO NOT TOOK RESPONSIBILITY FOR ANYHING THAT HAPPENS ONLY IF IS YOUR FAULTS."
ui_print "- README, Sources Codes, Credits, known/reported issues are on GitHub."
ui_print ""