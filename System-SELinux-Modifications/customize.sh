# Log the date and time
echo "- Time of execution: $(date)"

# Installations
ui_print ""
ui_print "- Preparing..."
ui_print "- Installing..."

# Android System Built-in SELinux Modification
ui_print ""
ui_print "- Modifying Android System Built-in SELinux..."
sh $MODPATH/system_files_chmods-1.sh
sh $MODPATH/system_selinux.sh
sh $MODPATH/system_files_chmods-2.sh
ui_print "- Completed."

# Completions
ui_print ""
ui_print "- Root Module is installed."
ui_print "- Please REBOOT/RESTART the Device for effects."
ui_print ""
ui_print "- ADDITIONAL NOTES:"
ui_print "- MAKE USE OF THE ROOT MODULE AT YOUR OWN RISKS."
ui_print "- DEVELOPERS ARE NOT TOOK RESPONSIBILITY FOR WHAT HAPPENED ONLY IF IS YOUR FAULTS."
ui_print ""