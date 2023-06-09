# space
ui_print " "

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
else
  ui_print " MagiskVersion=$MAGISK_VER"
  ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
fi
ui_print " "

# optionals
OPTIONALS=/sdcard/optionals.prop
if [ ! -f $OPTIONALS ]; then
  touch $OPTIONALS
fi

# check
FILE=/system/lib*/libinputflinger.so
ui_print "- Checking"
ui_print "$FILE..."
if ! grep -q ro.hw_timeout_multiplier $FILE; then
  abort "  ! Unsupported Android version."
fi
ui_print " "

# timeout
FILE=$MODPATH/system.prop
PROP=`grep_prop anr.timeout $OPTIONALS`
if [ "$PROP" ]; then
  ui_print "- Increases ANR timeout to $PROP x 5 secs."
  sed -i "s/ro.hw_timeout_multiplier=12/ro.hw_timeout_multiplier=$PROP/g" $FILE
  ui_print " "
else
  ui_print "- Increases ANR timeout to 12 x 5 secs."
  ui_print " "
fi





