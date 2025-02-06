#!/bin/bash
# Scrit scan que fiz para cups e impressora HP
# usando scanimage. 

scanimage -d $(scanimage -L | grep $1 | cut -c9- | cut -d"'" -f 1) --resolution 600dpi --format jpeg -o $2

# help
