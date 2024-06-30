mount -o rw,remount /data
MODPATH=${0%/*}

exec 2>$MODPATH/debug-pfsd.log
set -x

API=`getprop ro.build.version.sdk`
ABI=`getprop ro.product.cpu.abi`

permissive() {
if [ "$SELINUX" == Enforcing ]; then
  if ! setenforce 0; then
    echo 0 > /sys/fs/selinux/enforce
  fi
fi
}
magisk_permissive() {
if [ "$SELINUX" == Enforcing ]; then
  if [ -x "`command -v magiskpolicy`" ]; then
	magiskpolicy --live "permissive *"
  else
	$MODPATH/$ABI/libmagiskpolicy.so --live "permissive *"
  fi
fi
}
sepolicy_sh() {
if [ -f $FILE ]; then
  if [ -x "`command -v magiskpolicy`" ]; then
    magiskpolicy --live --apply $FILE 2>/dev/null
  else
    $MODPATH/$ABI/libmagiskpolicy.so --live --apply $FILE 2>/dev/null
  fi
fi
}

SELINUX=`getenforce`
chmod 0755 $MODPATH/*/libmagiskpolicy.so
#1permissive
#2magisk_permissive
#kFILE=$MODPATH/sepolicy.rule
#ksepolicy_sh
FILE=$MODPATH/sepolicy.pfsd
sepolicy_sh

FILE=$MODPATH/cleaner.sh
if [ -f $FILE ]; then
  . $FILE
  mv -f $FILE $FILE.txt
fi

mount -o rw,remount /data

MODPATH="${0%/*}"
amldir=
API="$(getprop ro.build.version.sdk)"
filenames="*audio*effects*.conf -o -name *audio*effects*.xml\
           -o -name *policy*.conf -o -name *policy*.xml\
           -o -name *mixer*paths*.xml -o -name *mixer*gains*.xml\
           -o -name *audio*device*.xml -o -name *sapa*feature*.xml\
           -o -name *audio*platform*info*.xml -o -name *audio*configs*.xml"

set_perm() {
  chown $2:$3 $1 || return 1
  chmod $4 $1 || return 1
  CON=$5
  [ -z $CON ] && CON=u:object_r:system_file:s0
  chcon $CON $1 || return 1
}
set_perm_recursive() {
  find $1 -type d 2>/dev/null | while read dir; do
    set_perm $dir $2 $3 $4 $6
  done
  find $1 -type f -o -type l 2>/dev/null | while read file; do
    set_perm $file $2 $3 $5 $6
  done
}
cp_mv() {
  mkdir -p "$(dirname "$3")"
  cp -af "$2" "$3"
  [ "$1" == "-m" ] && rm -f $2 || true
}
osp_detect() {
  local spaces effects type="$1"
  local files=$(find $MODPATH -type f -name "*audio*effects*.conf" -o -name "*audio*effects*.xml")
  for file in $files; do
    for osp in $type; do
      case $file in
        *.conf) spaces=$(sed -n "/^output_session_processing {/,/^}/ {/^ *$osp {/p}" $file | sed -r "s/( *).*/\1/g")
                effects=$(sed -n "/^output_session_processing {/,/^}/ {/^$spaces\$osp {/,/^$spaces}/p}" $file | grep -E "^$spaces +[A-Za-z]+" | sed -r "s/( *.*) .*/\1/g")
                for effect in ${effects}; do
                  spaces=$(sed -n "/^effects {/,/^}/ {/^ *$effect {/p}" $file | sed -r "s/( *).*/\1/g")
                  [ "$effect" != "atmos" -a "$effect" != "dtsaudio" ] && sed -i "/^effects {/,/^}/ {/^$spaces$effect {/,/^$spaces}/d}" $file
                done
                ;;
        *.xml) effects=$(sed -n "/^ *<postprocess>$/,/^ *<\/postprocess>$/ {/^ *<stream type=\"$osp\">$/,/^ *<\/stream>$/ {/<stream type=\"$osp\">/d; /<\/stream>/d; s/<apply effect=\"//g; s/\"\/>//g; s/ *//g; p}}" $file)
                for effect in ${effects}; do
                  [ "$effect" != "atmos" -a "$effect" != "dtsaudio" ] && sed -i "/^\( *\)<apply effect=\"$effect\"\/>/d" $file
                done
                ;;
      esac
    done
  done
  return 0
}

exec 2>$MODPATH/debug-pfsd.log
set -x

. $MODPATH/uninstall.sh
moddir="$(dirname $MODPATH)"
rm -rf $amldir $(find $MODPATH/system $MODPATH/vendor -type f) $MODPATH/errors.txt $MODPATH/system.prop 2>/dev/null
[ -f "$moddir/acdb/post-fs-data.sh" ] && mv -f $moddir/acdb/post-fs-data.sh $moddir/acdb/post-fs-data.sh.bak
mkdir $amldir
files="$(find /system /odm /my_product -type f -name $filenames)"
for file in $files; do
  name=$(echo "$file" | sed 's|/system||g')
  cp_mv -c $file $MODPATH/system$name
done
files="$(find /vendor -type f -name $filenames)"
if [ -L $MODPATH/system/vendor ]; then
  mkdir -p $MODPATH/vendor
fi
for file in $files; do
  if [ -L $MODPATH/system/vendor ]; then
    cp_mv -c $file $MODPATH$file
  else
    cp_mv -c $file $MODPATH/system$file
  fi
done
rm -f `find $MODPATH -type f -name *audio*effects*spatializer*.xml`
osp_detect "music"

for mod in $(find $moddir/* -maxdepth 0 -type d ! -name aml -a ! -name 'lost+found'); do
  modname="$(basename $mod)"
  [ -f "$mod/disable" ] && continue
  files="$(find $mod -type f -name $filenames 2>/dev/null)"
  [ "$files" ] && echo "$modname" >> $amldir/modlist || continue
  for file in $files; do
    cp_mv -m $file $amldir/$modname$(echo "$file" | sed "s|$mod||g")
  done
  if [ "$API" -ge 26 ]; then
    if [ -L $mod/system/vendor ] && [ -d $mod/vendor ]; then
      chcon -R u:object_r:vendor_file:s0 $mod/vendor/lib*/soundfx 2>/dev/null
    else
      chcon -R u:object_r:vendor_file:s0 $mod/system/vendor/lib*/soundfx 2>/dev/null
    fi
  fi
done

sh $MODPATH/copy.sh
sh $MODPATH/.aml.sh

if [ "$API" -ge 26 ]; then
  DIRS=`find $MODPATH/vendor\
             $MODPATH/system/vendor -type d`
  for DIR in $DIRS; do
    chown 0.2000 $DIR
  done
  chcon -R u:object_r:vendor_configs_file:s0 $MODPATH/system/odm/etc
  if [ -L $MODPATH/system/vendor ]\
  && [ -d $MODPATH/vendor ]; then
    chcon -R u:object_r:vendor_file:s0 $MODPATH/vendor
    chcon -R u:object_r:vendor_configs_file:s0 $MODPATH/vendor/etc
    chcon -R u:object_r:vendor_configs_file:s0 $MODPATH/vendor/odm/etc
  else
    chcon -R u:object_r:vendor_file:s0 $MODPATH/system/vendor
    chcon -R u:object_r:vendor_configs_file:s0 $MODPATH/system/vendor/etc
    chcon -R u:object_r:vendor_configs_file:s0 $MODPATH/system/vendor/odm/etc
  fi
fi

mount_helper() {
if [ -d /odm ]\
&& [ "`realpath /odm/etc`" == /odm/etc ]; then
  DIR=$MODPATH/system/odm
  FILES=`find $DIR -type f -name $AUD`
  for FILE in $FILES; do
    DES=/odm`echo $FILE | sed "s|$DIR||g"`
    umount $DES
    mount -o bind $FILE $DES
  done
fi
if [ -d /my_product ]; then
  DIR=$MODPATH/system/my_product
  FILES=`find $DIR -type f -name $AUD`
  for FILE in $FILES; do
    DES=/my_product`echo $FILE | sed "s|$DIR||g"`
    umount $DES
    mount -o bind $FILE $DES
  done
fi
}

if ! grep -E 'delta|Delta|kitsune' /data/adb/magisk/util_functions.sh; then
  mount_helper
fi