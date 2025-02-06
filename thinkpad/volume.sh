#!/bin/sh
[ "$(pactl get-sink-mute @DEFAULT_SINK@)" = "Mute: sim" ]  && echo 'Mudo!' || echo $(pactl get-sink-volume @DEFAULT_SINK@ | awk '/dB/ {print $14}' )"dB"
