#!/bin/sh
a=$(fzf --border rounded);
[ "$a" = "" ] && exit || case "$(echo $a | rev | cut -d . -f 1 | rev)" in 
	
ms | txt | MS | TXT | f95 | F95 | md) 
	st -e vim "$a" 2> /dev/null & disown ;
	;;
		
pdf | ps | PDF | PS )
	zathura "$a" 2> /dev/null & disown ;
	;;

jpg | png | webm | jpeg | JPEG | JPG | PNG )
	sxiv "$a" 2> /dev/null & disown ;
	;;

gif | GIF)
	sxiv -a "$a" 2> /dev/null & disown ;
	;;

	MP4 | MOV | WEBM | AVI | VOB | MKV |  FLV | DIVIX | DVIX | SVIDEO | VOB | GIFV | WMV | WMV | QT | RM | RMVB | M4P | M4V | MPG | MP2 | MPEG | MPE |MPV | 3GP | mp4 | mov | webm | avi | mkv | flv | divix | dvix | svideo | vob | gifv | wmv | wmv | qt | rm | rmvb | m4p | m4v | mpg | mp2 | mpeg | mpe |mpv | 3gp | vob)
	mpv "$a" 2> /dev/null & disown ;
	;;

MP3 | WAV | OGG | OPUS | M4A | mp3 | wav | ogg | opus | m4a) 
	st -t "TOCANDO $a" -e mpv 2> /dev/null "$a" & disown ;
	;;

doc | DOC | odt | ODT | xlsx | XLSX | docx | DOCX | ppt | PPT | pptx | PPTX | dotx | DOTX | FODP | fodp)
	libreoffice "$a" 2> /dev/null & disown;
	;;
*)
	xdg-open "$a";
	;;

esac
