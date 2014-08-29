#!/bin/sh
#echo "si!"
# this directory is a symlink on my machine:
KEYS_DIR=/sys/class/backlight/intel_backlight 

#echo "1"
test -d $KEYS_DIR || exit 0
#echo "2"
MIN=50000
MAX=$(cat $KEYS_DIR/max_brightness)
VAL=$(cat $KEYS_DIR/brightness)

#echo "Actual: " $VAL
if [ "$1" = down ]; then
	VAL=$((VAL-50000))
else
	VAL=$((VAL+50000))
fi
#echo "Nuevo: " $VAL

if [ "$VAL" -lt $MIN ]; then
	VAL=$MIN
elif [ "$VAL" -gt $MAX ]; then
	VAL=$MAX
fi

echo $VAL > $KEYS_DIR/brightness
