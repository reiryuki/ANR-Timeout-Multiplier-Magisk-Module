mount -o rw,remount /data
MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug-pfsd.log
set -x

# prop
PROP=`getprop ro.arch`
PROP2=`getprop ro.hardware`
PROP3=`getprop ro.product.board`
if [ ! "$PROP" ] && [ "$PROP2" ]; then
  resetprop -n ro.arch "$PROP2"
elif [ ! "$PROP" ] && [ "$PROP3" ]; then
  resetprop -n ro.arch "$PROP3"
fi






