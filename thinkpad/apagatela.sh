#!/bin/sh
# renomear para tela.sh ?
if [ -n "$1" ] && [ $1 -gt 0 ] && [ $1 -lt 15 ]; then
	echo $1 > /sys/class/backlight/acpi_video0/brightness
else
	if [ "$(cat /sys/class/backlight/acpi_video0/brightness)" -gt 1 ]; then
		echo 0 > /sys/class/backlight/acpi_video0/brightness
	else 
		echo 15 > /sys/class/backlight/acpi_video0/brightness
	fi
fi
#!/bin/bash


## antigo ajustegamma
# TODO: integrar

#echo "vermelho"
#read red
#echo "verde"
#read green
#echo "azul"
#read blue
#echo "brilho HDMI"
#read brilho1
#echo "brilho tela"
#read brilho2
#
#sudo xrandr --output HDMI-1 --gamma $red:$green:$blue --brightness $brilho1
#sudo echo $brilho2 >> /sys/class/backlight/intel_backlight/brightness
