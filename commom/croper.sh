#!/bin/sh
# Pequeno script para cortar vídeo em quadro

help(){ 
	echo "croper.sh [input-file] [output-file] [height] [width] [width-start] [height-start]" 
}
[ -z $1 ] && help && exit

if [ -z $5 ]; then
	hstart=0
else
	hstart="$6"
fi 

if [ -z $6 ]; then
	wstart=0 
else
	wstart="$5"
fi 

input="$1"
output="$2"
height="$3"
width="$4"

ffmpeg -i "$input" -vf crop="$width":"$height":"$wstart":"$hstart" $output
