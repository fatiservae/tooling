#!/bin/sh
# 1				2			3					4				5						6	
# normal shift shift+mod nao-sei nao-sei altGr+shift 
setxkbmap gb

#xmodmap -e 'keycode  11 = 2 quotedbl dead_diaeresis quotedbl twosuperior 2 twosuperior oneeighth 2 quotedbl'

xmodmap -e 'keycode  15 = 6 dead_circumflex 6 dead_circumflex threequarters fiveeighths threequarters'
# xmodmap -e 'keycode  21 = equal plus equal plus dead_cedilla dead_ogonek dead_cedilla'
# xmodmap -e 'keycode  34 = bracketleft braceleft bracketleft braceleft dead_diaeresis dead_abovering dead_diaeresis'
# xmodmap -e 'keycode  35 = bracketright braceright bracketright braceright dead_tilde dead_macron dead_tilde'
# xmodmap -e 'keycode  44 = j J j J dead_hook dead_horn dead_hook'
# xmodmap -e 'keycode  47 = semicolon colon semicolon colon dead_acute dead_doubleacute dead_acute'
xmodmap -e 'keycode  48 = dead_acute at dead_acute at dead_circumflex dead_caron dead_circumflex'
xmodmap -e 'keycode  49 = dead_grave notsign dead_grave notsign bar bar bar'
xmodmap -e 'keycode  11 = 2 quotedbl 2 quotedbl twosuperior dead_diaeresis twosuperior oneeighth 2 quotedbl twosuperior oneeighth'
xmodmap -e 'keycode  51 = numbersign dead_tilde numbersign dead_tilde dead_grave dead_breve dead_grave'
#xmodmap -e 'keycode  54 = c C ccedilla Ccedilla cent copyright cent'
xmodmap -e 'keycode  54 = c C c C ccedilla Ccedilla'
# xmodmap -e 'keycode  61 = slash question slash question dead_belowdot dead_abovedot dead_belowdot'

xmodmap -e 'keycode  67 = XF86AudioMute F1 F1 F1 F1 F1 F1'
xmodmap -e 'keycode  68 = XF86AudioLowerVolume F2 F2 F2 F2 F2 F2'
xmodmap -e 'keycode  69 = XF86AudioRaiseVolume F3 F3 F3 F3 F3 F3'
xmodmap -e 'keycode  70 = XF86AudioMicMute F4 F4 F4 F4 F4 F4'
xmodmap -e 'keycode  71 = XF86MonBrightnessDown F5 F5 F5 F5 F5 F5'
xmodmap -e 'keycode  72 = XF86MonBrightnessUp F6 F6 F6 F6 F6 F6'
xmodmap -e 'keycode  73 = XF86WebCam F7 F7 F7 F7 F7 F7'
xmodmap -e 'keycode  74 = XF86RFKill F8 F8 F8 F8 F8 F8'
xmodmap -e 'keycode  75 = XF86Tools F9 F9 F9 F9 F9 F9'
xmodmap -e 'keycode  76 = Find F10 F10 F10 F10 F10 F10'
xmodmap -e 'keycode  95 = XF86Launch1 F11 F11 F11 F11 F11 F11' 
xmodmap -e 'keycode  96 = XF86Launch2 F12 F12 F12 F12 F12 F12' 
xmodmap -e 'keycode  51 = dead_tilde numbersign dead_tilde numbersign dead_grave dead_breve dead_grave'
