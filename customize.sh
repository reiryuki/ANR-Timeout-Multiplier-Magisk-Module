# space
if [ "$BOOTMODE" == true ]; then
  ui_print " "
fi

# magisk
if [ -d /sbin/.magisk ]; then
  MAGISKTMP=/sbin/.magisk
else
  MAGISKTMP=`realpath /dev/*/.magisk`
fi

# path
if [ "$BOOTMODE" == true ]; then
  MIRROR=$MAGISKTMP/mirror
else
  MIRROR=
fi
SYSTEM=`realpath $MIRROR/system`
PRODUCT=`realpath $MIRROR/product`
VENDOR=`realpath $MIRROR/vendor`
SYSTEM_EXT=`realpath $MIRROR/system/system_ext`
ODM=`realpath /odm`
MY_PRODUCT=`realpath /my_product`

# optionals
OPTIONALS=/sdcard/optionals.prop

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
ui_print " MagiskVersion=$MAGISK_VER"
ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
ui_print " "

# check
FILE=$SYSTEM/lib*/libinputflinger.so
ui_print "- Checking"
ui_print "$FILE..."
if ! grep -Eq ro.hw_timeout_multiplier $FILE; then
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


