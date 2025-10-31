# Log the date and time
echo "- Time of execution: $(date)"

# Notes
ui_print ""
ui_print "- It will take some time."
ui_print "- Please wait and be patience until is completed."

# Premission
ui_print ""
ui_print "- Installing files and setting up premission..."
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
ui_print "- Installing files and setting up premission completed."

ui_print ""
ui_print "- Scripts executions completed, Root Module is installed."
ui_print "- Please REBOOT/RESTART the Device for effects."
ui_print ""
ui_print "- ADDITIONAL NOTES:"
ui_print "- INSTALL AND USE THIS ROOT MODULE AT YOUR OWN RISKS."
ui_print "- DEVELOPERS ARE NOT TOOK RESPONSIBILITY FOR WHAT HAPPENED ONLY IF IS YOUR FAULTS."
ui_print ""