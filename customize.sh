# Log the date and time
echo "- Time of execution: $(date)"

# Premission
ui_print ""
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
ui_print "- Setting Premission Completed."

# Scripts Executes
ui_print ""
ui_print "- It will take some time."
ui_print "- Please wait until is completed."
ui_print "- Executing Scripts..."

# Kernel Tweaks
ui_print ""
ui_print "- Fine-Tunning Android System/User/Kernel Settings, Tunables and Parameters..."
sh $MODPATH/tweaker.sh
ui_print "- Completed."

# ZRAM Swap Virtual Memory
ui_print ""
ZRAM=$MODPATH/virtual_memory.sh
if [ ! -f $ZRAM ]; then
  touch $ZRAM
fi

PROP=`grep_prop zram.resize $ZRAM`
ZRAM=/block/zram0
if [ "$PROP" == 0 ]; then
  ui_print "- ZRAM Swap Virtual Memory will be Disabled."
  ui_print ""
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
    ui_print "- To $PROP Physical RAM Size..."
    sed -i "s|DISKSIZE=1G|DISKSIZE=$PROP|g" $MODPATH/service.sh
  else
    ui_print "- To 1GBs of Physical RAM Size..."
  fi
  ui_print ""
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
    ui_print ""
  fi
  PROP=`grep_prop zram.prio $ZRAM`
  if [ "$PROP" ]; then
    ui_print "- Modifying swap priority $PROP..."
    sed -i "s|PRIO=0|PRIO=$PROP|g" $MODPATH/service.sh
  else
    ui_print "- Modifying Swap Priority to 0..."
  fi
  ui_print ""
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

# Thermal System Modification
ui_print "- Modifying Thermal System..."
function FindThermal(){
    for systemThermal in `ls $1 | grep $2`
    do
        if [[ "$systemThermal" == *"-Setfile1"* ]]; then
            ui_print "- Skip Conflicted File: $1/$systemThermal"
        elif [[ "$systemThermal" == *"-Setfile2"* ]]; then
            ui_print "- Skip Conflicted File: $1/$systemThermal"
        else
            ui_print "- Found: $1/$systemThermal"
            if [ $2 == "thermal" ];then
                if [ ! -f "$3/$systemThermal-Setfile1" ] ; then
                    echo "" > "$3/$systemThermal-Setfile1"
                fi
                if [ ! -f "$3/$systemThermal-Setfile2" ] ; then
                    cp -af "$1/$systemThermal" "$3/$systemThermal-Setfile2"
                fi
                cp -af "$3/$systemThermal-Setfile1" "$3/$systemThermal"
            else
                if [ ! -f "$3/$systemThermal" ] ; then
                    cp -af "$1/$systemThermal" "$3/$systemThermal"
                fi
            fi
        fi
    done
}
FindThermal "/system/bin" '"-Setfile2"' "$MODPATH/system/bin"
FindThermal "/system/bin" 'thermal' "$MODPATH/system/bin"
FindThermal "/system/etc" '"-Setfile2"' "$MODPATH/system/etc"
FindThermal "/system/etc" 'thermal' "$MODPATH/system/etc"
FindThermal "/vendor/bin" '"-Setfile2"' "$MODPATH/system/vendor/bin"
FindThermal "/vendor/bin" 'thermal' "$MODPATH/system/vendor/bin"
FindThermal "/vendor/etc" '"-Setfile2"' "$MODPATH/system/vendor/etc"
FindThermal "/vendor/etc" 'thermal' "$MODPATH/system/vendor/etc"
ui_print "- Completed."
ui_print ""

ui_print "- Script execution completed, Root Module is installed."
ui_print "- It's may Recommended to REBOOT the Device."
ui_print ""
ui_print "- ADDITIONAL NOTES:"
ui_print "- INSTALL AND USE THIS MODULE AT YOUR OWN RISKS."
ui_print "- DEVELOPERS ARE DO NOT TOOK RESPONSIBILITY FOR ANYHING THAT HAPPENS ONLY IF IS YOUR FAULTS."
ui_print "- README, Sources Codes, Credits, known/reported issues are on GitHub."
ui_print ""