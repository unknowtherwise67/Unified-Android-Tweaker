# Log the date and time
echo "- Time of execution: $(date)"

# Installations.
ui_print ""
ui_print "- Preparing..."
ui_print "- Installing..."

# Android System Kernel Modifications
ui_print ""
ui_print "- Fine-tunning Android System/User/Kernel settings, tunables and other parameters..."
sh $MODPATH/system_settings.sh
sh $MODPATH/system_governors.sh
sh $MODPATH/system_kernel.sh
sh $MODPATH/system_cpu_gpu_power.sh
ui_print "- Completed."

# ZRAM/Swap Virtual Memory
ui_print ""
ZRAM=$MODPATH/system_virtual_memory.sh
if [ ! -f $ZRAM ]; then
  touch $ZRAM
fi
VAL=`grep_prop zram.resize $ZRAM`
ZRAM=/block/zram0
FILE=/sys$ZRAM/disksize
FILE2=/sys$ZRAM/comp_algorithm
CUR=`cat $FILE`
CUR2=`cat $FILE2`
if [ "$VAL" == 0 ]; then
  ui_print "- System ZRAM/Swap Virtual Memory will be DISABLED."
  ui_print ""
else
  MemTotal=`awk '/MemTotal/ {print $2}' /proc/meminfo`
  ui_print "- Modifying $FILE..."
  sed -i 's|#o||g' $MODPATH/service.sh
  if echo "$VAL" | grep -q %; then
    ui_print "  to $VAL of RAM size."
    VAL=`echo "$VAL" | sed 's|%||g'`
    let RES="$MemTotal * $VAL / 100 * 1024"
    ui_print "  ($RES Byte)"
    sed -i "s|VAR|$VAL|g" $MODPATH/service.sh
    sed -i 's|#%||g' $MODPATH/service.sh
  elif [ "$VAL" ]; then
    ui_print "  to $VAL Byte."
    sed -i "s|DISKSIZE=|DISKSIZE=$VAL|g" $MODPATH/service.sh
  else
    ui_print "  to 100% of RAM size."
    let RES="$MemTotal * 1024"
    ui_print "  ($RES Byte)"
    sed -i "s|VAR|100|g" $MODPATH/service.sh
    sed -i 's|#%||g' $MODPATH/service.sh
  fi
  ui_print ""
  VAL=`grep_prop zram.algo $ZRAM`
  if [ "$VAL" ]; then
    if grep -q "$VAL" $FILE2; then
      ui_print "- Modifying $FILE2..."
      ui_print "  to $VAL"
      sed -i "s|ALGO=|ALGO=$VAL|g" $MODPATH/service.sh
    else
      ui_print "! $VAL is Unsupported"
      ui_print "  in $FILE2"
    fi
    ui_print ""
  fi
  VAL=`grep_prop zram.prio $ZRAM`
  if [ "$VAL" ]; then
    ui_print "- Modifying Swap Priority to $VAL..."
    sed -i "s|PRIO=|PRIO=$VAL|g" $MODPATH/service.sh
  else
    ui_print "- Modifying Swap Priority to 0..."
    sed -i 's|PRIO=|PRIO=0|g' $MODPATH/service.sh
  fi
fi

# Completions
ui_print ""
ui_print "- Root Module and its files and scripts installations and executions are completed."
ui_print "- Please REBOOT/RESTART the Device for effects."
ui_print ""
ui_print "- ADDITIONAL NOTES:"
ui_print "- MAKE USE OF THE ROOT MODULE AT YOUR OWN RISKS."
ui_print "- DEVELOPERS ARE NOT TOOK RESPONSIBILITY FOR WHAT HAPPENED ONLY IF IS YOUR FAULTS."
ui_print ""