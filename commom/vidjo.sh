#!/bin/sh
# By Jefferson T. @ 2022
# Um baixador de vídeos dentro da capacidade de yt-dlp
# Este script não adiciona capacidades a yt-dlp, apenas automatiza
# e organiza seu funcionament.

helper(){
	echo 'Argumentos são:';
	echo '	vidjo.sh:					baixa vídeo separado de áudio e toca juntos';
	echo '	vidjo.sh --simple:			baixa vídeo em container único';
	echo '	vidjo.sh --merge:			baixa vídeo separado de áudio e mescla usando ffmpeg';
	echo '	vidjo.sh --merge --del :	baixa vídeo separado de áudio, mescla e deleta arquivos separados';
	exit
}

src="$(xclip -o -selection clipboard)";
if [ "${src#http}" != "$src" ]; then
		name="$(yt-dlp --get-title "$src" 2>/dev/null | normalizador -res)";
		random="$RANDOM";
else
		echo "Clipboard não é uma URL!";
		helper;
		exit
fi

case "${1-_is_unset_}" in 
	_is_unset_)
		"$(yt-dlp -o "__audio$random" --format "ba" "$src")";
		"$(yt-dlp -o "__video$random" --format "bv[height<1080]" "$src")";
		ffmpeg -i "__video$random" -i "__audio$random" -c:v copy -c:a copy "$name.mp4";
		rm "__audio$random" "__video$random";
		#mpv  --cache=yes --stream-record="./$name.mp4" --audio-file="./__audio$name" "./__video$name";
		#mpv --cache=yes --stream-record="./$name.mp4" --audio-file="./__audio$name" "./__video$name";
;;
	--simple)
		"$(yt-dlp -o "__video$name" --format "[height<1080]" "$src")";
;;
# deprecado?
	--merge)
		"$(yt-dlp -o "__audio$name" --format "ba" "$src")";
		"$(yt-dlp -o "__video$name" --format "bv[height<1080]" "$src")";
		ffmpeg -i "./__video$name" -i "./__audio$name" -c:v copy -c:a aac "$name.mp4"
		case "$2" in 
			*) 
				echo 'help2!';
				exit
		;;
			--del)
				rm "./__*";
		;;
		esac
;;
	--yt-cookies)
		##[ -z $(< /home/jefferson/.cookies) ] && echo 'Arquivo /home/jefferson/.cookies não encontrado' && exit
		"$(yt-dlp --cookies "/home/jefferson/.cookies" -o "__audio$random" --format "ba" "$src")";
		"$(yt-dlp --cookies "/home/jefferson/.cookies" -o "__video$random" --format "bv[height<1080]" "$src")";
		ffmpeg -i "__video$random" -i "__audio$random" -c:v copy -c:a copy "$name.mp4";
;;
	*) 
		helper;
;;
esac
#ext="$(yt-dlp --get-format $video)";
#filename="$name.$ext";
#mpv --cache=yes --stream-record="./$name.mp4" --audio-file="./__audio$name" "./__video$name";
#yt-dlp -o  "__buff_video" -f "bv[height<=720]"+"ba" "$(xclip -o -selection clipboard)"
#yt-dlp -o "__buff_audio" "$(xclip -o -selection clipboard)";
#ffmpeg -i "./__buff_video" -i "./__buff_audio" -c:v copy -c:a aac video$RANDOM.mp4
#"%(title)s.%(ext)s"
#[ "$1" = "-n" ] || {
#  yt-dlp -o "%(title)s.%(ext)s" --format "[ext=mp4]" "$(xclip -o -selection clipboard)"
#} && {
#  yt-dlp -o "video$RANDOM.mp4" --format "[ext=mp4]" "$(xclip -o -selection clipboard)"
#}
