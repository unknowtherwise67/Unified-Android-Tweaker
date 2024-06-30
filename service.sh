MODPATH=${0%/*}
MODDIR=${0%/*}
sh $MODDIR/util_functions.sh

until resetprop sys.boot_completed; do
    press_check && disable_modules
done

# ZRAM Virtual Memory
swapoff /dev/block/zram0

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done

DEF=`cat /sys/block/zram0/disksize`
DEF=`cat /sys/block/zram0/comp_algorithm`
DEF=`cat /proc/sys/vm/swappiness`
DEF=`getprop ro.lmk.swap_free_low_percentage`
DEF=`getprop ro.lmk.thrashing_limit_critical`

# zram
#ALGO=
#oZRAM=3G
#%MemTotalStr=`cat /proc/meminfo | grep MemTotal`
#%MemTotal=${MemTotalStr:16:8}
#%let VALUE="$MemTotal * VAR / 100"
#%ZRAM=$VALUE\K
swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
if [ "$ALGO" ]; then
  echo "$ALGO" > /sys/block/zram0/comp_algorithm
fi
#oecho 100 > /proc/sys/vm/swappiness
#oecho "$ZRAM" > /sys/block/zram0/disksize
#omkswap /dev/block/zram0
#oswapon /dev/block/zram0

# Kernel Tweaks
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 10
$MODPATH/tweaker.sh

# Audio Modification Library
moddir="$(dirname $MODPATH)"
amldir=
API="$(getprop ro.build.version.sdk)"
[ "$API" -ge 26 ] && libdir="/vendor" || libdir="/system"

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
patch_cfgs() {
  local first=true files="" file lib=false effect=false outsp=false proxy=false replace=false libname libpath effname uid libname_sw uid_sw libname_hw uid_hw libpathsw libpathhw conf xml
  local opt=`getopt :fleoqpr "$@"`
  eval set -- "$opt"
  while true; do
    case "$1" in
      -f) files="placeholder"; shift;;
      -l) lib=true; first=false; shift;;
      -e) effect=true; first=false; shift;;
      -o) outsp=true; conf=output_session_processing; xml=postprocess; first=false; shift;;
      -q) outsp=true; conf=pre_processing; xml=preprocess; first=false; shift;;
      -p) proxy=true; effect=false; outsp=false; first=false; shift;;
      -r) replace=true; shift;;
      --) shift; break;;
      *) return 1;;
    esac
  done
  [ -z "$files" ] && files="$(find $MODPATH -type f -name "*audio*effects*.conf" -o -name "*audio*effects*.xml")" || { files="$1"; shift; }
  $first && { lib=true; effect=true; }
  if $proxy; then
    effname=$1; uid=${2:?}; shift 2
    libname_sw=$1; uid_sw=${2:?}; shift 2
    $lib && { libpathsw=$1; shift; }
    libname_hw=$1; uid_hw=${2:?}; shift 2
    $lib && { libpathhw=${1:?}; shift; }
  else
    $outsp && { type=${1:?}; shift; }
    { $effect || $outsp; } && { effname=${1:?}; shift; }
    $effect && { uid=${1:?}; shift; }
    { $lib || $effect; } && { libname=${1:?}; shift; }
    $lib && { libpath=${1:?}; shift; }
  fi
  for file in $files; do
    case "$file" in
    *.conf)
      if $proxy; then
        if $replace && [ "$(sed -n "/^effects {/,/^}/ {/^  $effname {/,/^  }/p}" $file)" ]; then
          spaces=$(sed -n "/^effects {/,/^}/ {/^ *$effname {/p}" $file | sed -r "s/( *).*/\1/g")
          sed -i "/^effects {/,/^}/ {/^$spaces$effname {/,/^$spaces}/d}" $file
        fi
        [ ! "$(sed -n "/^effects {/,/^}/ {/^  $effname {/,/^  }/p}" $file)" ] && sed -i "s/^effects {/effects {\n  $effname {\n    library proxy\n    uuid $uid\n\n    libsw {\n      library $libname_sw\n      uuid $uid_sw\n    }\n\n    libhw {\n      library $libname_hw\n      uuid $uid_hw\n    }\n  }/g" $file
        if $lib; then
          patch_cfgs -fl "$file" "proxy" "$libdir/lib/soundfx/libeffectproxy.so"
          if $replace; then
            patch_cfgs -frl "$file" "$libname_sw" "$libpathsw"
            patch_cfgs -frl "$file" "$libname_hw" "$libpathhw"
          else
            patch_cfgs -fl "$file" "$libname_sw" "$libpathsw"
            patch_cfgs -fl "$file" "$libname_hw" "$libpathhw"
          fi
        fi
      else
        if $lib; then
          if $replace && [ "$(sed -n "/^libraries {/,/^}/ {/^ *$libname {/,/}/p}" $file)" ]; then
            spaces=$(sed -n "/^libraries {/,/^}/ {/^ *$libname {/p}" $file | sed -r "s/( *).*/\1/g")
            sed -i "/^libraries {/,/^}/ {/^$spaces$libname {/,/^$spaces}/d}" $file
          fi
          [ ! "$(sed -n "/^libraries {/,/^}/ {/^ *$libname {/,/}/p}" $file)" ] && sed -i "s|^libraries {|libraries {\n  $libname {\n    path $libpath\n  }|g" $file
        fi
        if $effect; then
          if $replace && [ "$(sed -n "/^effects {/,/^}/ {/^ *$effname {/,/}/p}" $file)" ]; then
            spaces=$(sed -n "/^effects {/,/^}/ {/^ *$effname {/p}" $file | sed -r "s/( *).*/\1/g")
            sed -i "/^effects {/,/^}/ {/^$spaces$effname {/,/^$spaces}/d}" $file
          fi
          [ ! "$(sed -n "/^effects {/,/^}/ {/^ *$effname {/,/}/p}" $file)" ] && sed -i "s|^effects {|effects {\n  $effname {\n    library $libname\n    uuid $uid\n  }|g" $file
        fi
        if $outsp && [ "$API" -ge 26 ]; then
          local OIFS=$IFS; local IFS=','
          for i in $type; do
            if [ ! "$(sed -n "/^$conf {/,/^}/p" $file)" ]; then
              echo -e "\n$conf {\n    $i {\n        $effname {\n        }\n    }\n}" >> $file
            elif [ ! "$(sed -n "/^$conf {/,/^}/ {/$i {/,/^    }/p}" $file)" ]; then
              sed -i "/^$conf {/,/^}/ s/$conf {/$conf {\n    $i {\n        $effname {\n        }\n    }/g" $file
            elif [ ! "$(sed -n "/^$conf {/,/^}/ {/$i {/,/^    }/ {/$effname {/,/}/p}}" $file)" ]; then
              sed -i "/^$conf {/,/^}/ {/$i {/,/^    }/ s/$i {/$i {\n        $effname {\n        }/}" $file
            fi
          done
          local IFS=$OIFS
        fi
      fi
      ;;
    *.xml)
      if $proxy; then
        if $replace && [ "$(sed -n "/<effects>/,/<\/effects>/ {/^ *<effectProxy name=\"$effname\".*>/,/^ *<\/effectProxy>/p}" $file)" -o "$(sed -n "/<effects>/,/<\/effects>/ {/^ *<effect name=\"$effname\".*\/>/p}" $file)" ]; then
          sed -i "/<effects>/,/<\/effects>/ {/^ *<effectProxy name=\"$effname\".*>/,/^ *<\/effectProxy>/d}" $file
          sed -i "/<effects>/,/<\/effects>/ {/^ *<effect name=\"$effname\".*\/>/d}" $file
        fi
        [ ! "$(sed -n "/<effects>/,/<\/effects>/ {/^ *<effectProxy name=\"$effname\".*>/,/^ *<\/effectProxy>/p}" $file)" -a ! "$(sed -n "/<effects>/,/<\/effects>/ {/^ *<effect name=\"$effname\".*>/,/^ *\/>/p}" $file)" ] && sed -i -e "/<effects>/ a\        <effectProxy name=\"$effname\" library=\"proxy\" uuid=\"$uid\">\n            <libsw library=\"$libname_sw\" uuid=\"$uid_sw\"\/>\n            <libhw library=\"$libname_hw\" uuid=\"$uid_hw\"\/>\n        <\/effectProxy>" $file
        if $lib; then
          patch_cfgs -fl "$file" "proxy" "$libdir/lib/soundfx/libeffectproxy.so"
          if $replace; then
            patch_cfgs -frl "$file" "$libname_sw" "$libpathsw"
            patch_cfgs -frl "$file" "$libname_hw" "$libpathhw"
          else
            patch_cfgs -fl "$file" "$libname_sw" "$libpathsw"
            patch_cfgs -fl "$file" "$libname_hw" "$libpathhw"
          fi
        fi
      else
        if $lib; then
          if $replace && [ "$(sed -n "/<libraries>/,/<\/libraries>/ {/^ *<library name=\"$libname\" path=\"$(basename $libpath)\"\/>/p}" $file)" ]; then
            sed -i "/<libraries>/,/<\/libraries>/ {/^ *<library name=\"$libname\" path=\"$(basename $libpath)\"\/>/d}" $file
          fi
          [ ! "$(sed -n "/<libraries>/,/<\/libraries>/ {/^ *<library name=\"$libname\" path=\"$(basename $libpath)\"\/>/p}" $file)" ] && sed -i "/<libraries>/ a\        <library name=\"$libname\" path=\"$(basename $libpath)\"\/>" $file
        fi
        if $effect; then
          if $replace && [ "$(sed -n "/<effects>/,/<\/effects>/ {/^ *<effect name=\"$effname\".*\/>/p}" $file)" -o "$(sed -n "/<effects>/,/<\/effects>/ {/^ *<effectProxy name=\"$effname\".*>/,/^ *<\/effectProxy>/p}" $file)" ]; then
            sed -i "/<effects>/,/<\/effects>/ {/^ *<effect name=\"$effname\".*\/>/d}" $file
            sed -i "/<effects>/,/<\/effects>/ {/^ *<effectProxy name=\"$effname\".*>/,/^ *<\/effectProxy>/d}" $file
          fi
          [ ! "$(sed -n "/<effects>/,/<\/effects>/ {/^ *<effect name=\"$effname\".*\/>/p}" $file)" ] && sed -i "/<effects>/ a\        <effect name=\"$effname\" library=\"$(basename $libname)\" uuid=\"$uid\"\/>" $file
        fi
        if $outsp && [ "$API" -ge 26 ]; then
          local OIFS=$IFS; local IFS=','
          for i in $type; do
            if [ ! "$(sed -n "/^ *<$xml>/,/^ *<\/$xml>/p" $file)" ]; then
              sed -i "/<\/audio_effects_conf>/i\    <$xml>\n       <stream type=\"$type\">\n            <apply effect=\"$effname\"\/>\n        <\/stream>\n    <\/$xml>" $file
            elif [ ! "$(sed -n "/^ *<$xml>/,/^ *<\/$xml>/ {/<stream type=\"$type\">/,/<\/stream>/p}" $file)" ]; then
              sed -i "/^ *<$xml>/,/^ *<\/$xml>/ s/    <$xml>/    <$xml>\n        <stream type=\"$type\">\n            <apply effect=\"$effname\"\/>\n        <\/stream>/g" $file
            elif [ ! "$(sed -n "/^ *<$xml>/,/^ *<\/$xml>/ {/<stream type=\"$type\">/,/<\/stream>/ {/^ *<apply effect=\"$effname\"\/>/p}}" $file)" ]; then
              sed -i "/^ *<$xml>/,/^ *<\/$xml>/ {/<stream type=\"$type\">/,/<\/stream>/ s/<stream type=\"$type\">/<stream type=\"$type\">\n            <apply effect=\"$effname\"\/>/}" $file
            fi
          done
          local IFS=$OIFS
        fi
      fi
      ;;
    esac
  done
  return 0
}
legacy_script() {
  local RUNONCE=false COUNT=1 LIBDIR=$libdir/lib/soundfx MOD=$mod
  (. $mod/.aml.sh) || echo "Error in $modname aml.sh script" >> $MODPATH/errors.txt
  for file in $files; do
    local NAME=$(echo "$file" | sed "s|$mod|system|g")
    $RUNONCE || { case $file in
                    *audio*effects*) (. $mod/.aml.sh) || [ "$(grep -x "$modname" $MODPATH/errors.txt)" ] || echo "Error in $modname aml.sh script" >> $MODPATH/errors.txt; COUNT=$(($COUNT + 1));;
                  esac; }
  done
}

(
exec 2>$MODPATH/debug.log
set -x

for mod in $(find $moddir/* -maxdepth 0 -type d ! -name aml); do
  modname="$(basename $mod)"
  [ -f "$mod/disable" ] && continue
  [ -f "$mod/aml.sh" ] && cp -f $mod/aml.sh $mod/.aml.sh
  if [ -f "$mod/.aml.sh" ]; then
    grep -qx "$modname" $amldir/modlist || echo "$modname" >> $amldir/modlist
    if grep -qE '\$MODPATH/\$NAME|RUNONCE=|COUNT=' $mod/.aml.sh; then
      legacy_script
    else
      (. $mod/.aml.sh) || echo "Error in $modname aml.sh script" >> $MODPATH/errors.txt
    fi
  else
    if [ -L $MODPATH/system/vendor ]; then
      libs="$(find $mod/vendor/lib/soundfx $mod/system/lib/soundfx -type f <libs> 2>/dev/null)"
    else
      libs="$(find $mod/system/vendor/lib/soundfx $mod/system/lib/soundfx -type f <libs> 2>/dev/null)"
    fi
    for lib in $libs; do
      for audmod in $MODPATH/.scripts/$(basename $lib)~*; do
        uuid=$(basename $audmod | sed -r "s/.*~(.*).sh/\1/g")
        hexuuid="$(echo $uuid | sed -r -e "s/^(..)(..)(..)(..)-(..)(..)-(..)(..)-/\4\3\2\1\6\5\8\7-/g" -e "s/-(..)(..)-(............)$/\2\1\3/g")"
        xxd -p $lib | tr -d '\n' | grep -q "$hexuuid" || continue
        $(grep -xq "$modname" $amldir/modlist 2>/dev/null) || echo "$modname" >> $amldir/modlist
        libfile="$(echo $lib | sed -e "s|$mod||g" -e 's|/system/vendor|/vendor|g')"
        . $audmod
      done
    done
  fi
done

for i in $(find $MODPATH/system $MODPATH/vendor -type f); do
  j="$(echo $i | sed -e "s|$MODPATH||g" -e 's|/system/odm|/odm|g' -e 's|/system/my_product|/my_product|g')"
  umount $j
  mount -o bind $i $j
done
[ "$API" -ge 24 ] && killall audioserver || killall mediaserver
killall android.hardware.audio@4.0-service-mediatek
exit 0
)&

# AudioFX Modification
API=`getprop ro.build.version.sdk`

if [ "$API" -ge 24 ]; then
  SERVER=audioserver
else
  SERVER=mediaserver
fi
killall $SERVER\
 android.hardware.audio@4.0-service-mediatek

until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done
sleep 20

AML=/data/adb/modules/aml
if [ -L $AML/system/vendor ]\
&& [ -d $AML/vendor ]; then
  DIR=$AML/vendor/odm/etc
else
  DIR=$AML/system/vendor/odm/etc
fi
if [ "$API" -ge 26 ] && [ -d $DIR ]\
&& [ ! -f $AML/disable ]; then
  chcon -R u:object_r:vendor_configs_file:s0 $DIR
fi
AUD=`grep AUD= $MODPATH/copy.sh | sed -e 's|AUD=||g' -e 's|"||g'`
if [ -L $AML/system/vendor ]\
&& [ -d $AML/vendor ]; then
  DIR=$AML/vendor
else
  DIR=$AML/system/vendor
fi
FILES=`find $DIR -type f -name $AUD`
if [ -d $AML ] && [ ! -f $AML/disable ]\
&& find $DIR -type f -name $AUD; then
  if ! grep '/odm' $AML/post-fs-data.sh && [ -d /odm ]\
  && [ "`realpath /odm/etc`" == /odm/etc ]; then
    for FILE in $FILES; do
      DES=/odm`echo $FILE | sed "s|$DIR||g"`
      if [ -f $DES ]; then
        umount $DES
        mount -o bind $FILE $DES
      fi
    done
  fi
  if ! grep '/my_product' $AML/post-fs-data.sh\
  && [ -d /my_product ]; then
    for FILE in $FILES; do
      DES=/my_product`echo $FILE | sed "s|$DIR||g"`
      if [ -f $DES ]; then
        umount $DES
        mount -o bind $FILE $DES
      fi
    done
  fi
fi

DMAF=`dumpsys media.audio_flinger`

exit 0