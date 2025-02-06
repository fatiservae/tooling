#!/bin/bash
case $1 in 
	""|-h|h|help|--help|ajuda|-ajuda|--ajuda|-help)
	printf "Uso:\ngravador \'denominador_resolução\' \'nome_saida\' \'formato_saida\'\n" 
	;;

	*)
	ffmpeg -f x11grab -video_size 1360x768 -framerate 60 -i :0.0+1366,0 -f pulse -i default -preset ultrafast -crf 18 -pix_fmt yuv420p -vf scale=iw/"$1":ih/"$1" "$2"."$3"
	;;

esac
# ffmpeg -f x11grab -video_size 2560x1600 -framerate 30 -i :0.0 -f pulse -i default -preset ultrafast -crf 18 -pix_fmt yuv420p -vf "$2"."$3"
