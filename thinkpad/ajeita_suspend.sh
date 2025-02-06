#!/bin/bash
for f in $(cat /proc/acpi/wakeup | grep enabled | awk '{print $1}'); do 
	echo $f | sudo tee /proc/acpi/wakeup 
done
exit
