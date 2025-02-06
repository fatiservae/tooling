#!/bin/bash
#		Um 'opener' hardcoded e KISS para substituir XDG_OPEN
#   By Jefferson T. @ 2023
#
#		TODO: Eliminar os caracters 
#		especiais que aparecem como 
#		<char>.

IFS="`printf '\n\t'`"

pega_extensao() {
	ext="$(echo "$1" | rev | cut -d . -f 1 | rev | tr '[:upper:]' '[:lower:]')"
	ext_lenght=${#ext}
	ext_lenght="$(( "$ext_lenght" + 1))"
	nome="$(echo "$1" | rev | cut -b "$ext_lenght"- | rev)"
	export nome ext 
}
helping() {
	printf "Jopener - um opener ridiculamente simples!\n\n-h\tHelp!\n-d\tEspecifica o diretório.\n-v\tAbre quaisquer arquivos ou diretórios em Helix.\n-vd|dv\tEspecifica um diretório e abre a seleção com Helix.\n\nPor Jefferson T. 2023 - Telegrão @StalinCCCP.\nLivre, pode copiar pô.\n"
}

if [ $# -eq 0 ]; then
	for i in "$(fzf -m --cycle --reverse --border rounded)"; do
	arquivos+=($i)
	done
elif expr "$1" : '^-[[:alpha:]]\{1,\}$' >/dev/null; then
	case "$1" in
		-d)
		for i in $(find $2 -maxdepth 20 | fzf -m --cycle --reverse  --border rounded); do
		arquivos+=($i)
		done
	;;
		-v)
			if [ $# -gt 1 ]; then
				for i in ${@:2}; do arquivos+=($i); done
			else
				for i in $(fzf -m --cycle --reverse --border rounded); do
				arquivos+=($i)
				done
			fi
		[ $arquivos == '' ] && exit
		alacritty -e helix $arquivos && exit
	;;
		-vd|-dv)
		[ $# -gt 2 ] && echo "Passe apenas o caminho do arquivo a ser aberto com Helix!"
		for i in "$(find $2 -maxdepth 10 | fzf -m --reverse --cycle --border rounded)"; do
		arquivos+=($i)
		[ $arquivos == '' ] && exit 
		alacritty -e helix $arquivos && exit
		done
	;;
		-h)
		helping
	;;
		*)
		echo "OPÇÃO INVÁLIDA!"
		helping
	;;
	esac
else
	for i in "$@"; do arquivos+=($i); done
fi

[ "${#arquivos}" = 0  ] && echo 'Nenhum arquivo conhecido! Saindo...' && exit

for arquivo in ${arquivos[@]}; do
		pega_extensao $arquivo
		[ -z $nome ] && exit
		case $ext in
			jpeg|jpg|gif|png|webp|svg)
			imagem=true
			imagens+=($arquivo)
			;;
			pdf|epub|ps)
			reader=true
			readers+=($arquivo)
			;;
			mp4|mkv|mov|webm|avi|divx|flv|divix|dvix|svideo|vob|wmv|qt|\rm|rmvb|m4p|m4v|mpg|mp2|mpeg|mpe|mpv|3gp|riff)
			video=true
			videos+=($arquivo)
			;;
			mp3|ogg|opus|wav|m4a|aac)
			audio=true
			audios+=($arquivo)
			;;
			doc|docx|odp|odt|pps|pptx|ods|xlsx|ppt|dotx|fodp|odg|rtf)
			office=true
			offices+=($arquivos)
			;;
			htm|html)
			internet=true
			internets+=($arquivos)
			;;
			*)
			texto=true
			textos+=($arquivo)
			;;
	esac
done
IFS=
[ $video ] && nohup mpv ${videos[@]} > /dev/null 2>&1 &
[ $reader ] && nohup zathura ${readers[@]} > /dev/null 2>&1 &
[ $internet ] && nohup firefox ${internets[@]} > /dev/null 2>&1 &
[ $imagem ] && nohup sxiv -a ${imagens[@]} > /dev/null 2>&1 &
[ $texto ] && nohup alacritty -e helix "${textos[@]}" > /dev/null 2>&1 &
[ $audio ] && nohup alacritty -e mpv ${audios[@]} > /dev/null 2>&1 & 
[ $office ] && nohup libreoffice ${offices[@]} > /dev/null 2>&1 &
