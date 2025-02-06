#!/bin/sh
arg1=$1
IFS=$'\n'; i=1;
saideira() {
	rm $(\ls | grep jthumb_)
	echo 'Fim!'
	exit
}

main(){
for arquivo in $(\ls | grep -ie mp4 -ie mkv -ie mov -ie avi); do 
		set -- "$@" "$arquivo"
#		video="$(echo "$arquivo" | sed s/\.mp4//g | sed s/\.mov//g | sed s/\.avi//g | sed s/\.mkv//g)"
#		videos+=( "$video")
	done
#[ -z "$videos" ] && echo 'Não tem arquivos de vídeo!' && exit
[ "$*" = '' ] && echo 'Não tem arquivos de vídeo!' && exit

echo 'Aguarde...'

for f in $@; do
		video="$(echo $f | sed s/\.mp4//g | sed s/\.mov//g | sed s/\.avi//g | sed s/\.mkv//g)";
		case $arg1 in
			-jpg)
		ffmpeg -hide_banner -loglevel error -i $(\ls | grep "$video") -ss 3 -f image2 -frames:v 1 "jthumb_"$f".jpg"
;;
			*)
		ffmpeg -hide_banner -loglevel error -i $(\ls | grep "$video") -ss 3 -to 6 -filter:v scale="iw/2:ih/2" "jthumb_"$f".gif"
;;
esac
done
continuar="s"
while [ "$continuar" = "s" ]; do
			lista="$(sxiv -ao $(\ls | grep jthumb) | sed s/\.jpg//g | cut -b 7-)"
			[ "$lista" = '' ] && echo 'Saiu sem elaborar lista!' && saideira 
			echo 'Deletar (d) renomear (r) ou mover (m)?'
			read resposta
			
			case $resposta in
				deletar | d | 1 | apagar | remover | D | del)
						for g in $lista;
								do del $(ls | grep "$g" | grep -v jpg)
								rm $(\ls | grep "$g" | grep jpg)
						done
				;;
				mover | m | M | 2 | move)
						echo 'Digite destino em caminho absoluto'
						read -e destino && [ "$destino" = '' ] && echo 'Saiu sem destino!' && saideira
						for k in $lista;do 
								mkdir "$destino"
								mv -t $destino $(\ls | grep "$k" | grep -v jpg)
								rm $(\ls | grep "$k" | grep jpg)
						done
				;;
				renomear | r | ren | 3 | rename | R)
						for j in $lista; do
								mpv --really-quiet $(\ls | grep "$j" | grep -v jpg)
								echo 'Nome atual:'
								echo $(\ls | grep "$j" | grep -v jpg);
								echo 'Entre novo nome:'
								read nome;
								mv $(\ls | grep "$j" | grep -v jpg) "$nome"
								rm $(\ls | grep "$j" | grep jpg)
						done	
				;;

				*)
						echo 'jvidjo não conhece esta opção!'	&& saideira
			esac
			echo 'Continuar?'
			read continuar
done
}
main
saideira
