#!/bin/sh
# este script executa diversas funcoes sobre o nome dos arquivos 
# que lhe sao passados a fim de regulariza-los retirando espacos,
# caracters estranhos, acentos etc.
# Se quiser, adicione funcoes com transformacoes que desejar e 
# adicione a funcao no streaming final
# Telegrão: STALINCCCP 
# @2021
# Jefferson T.
IFS=$'\n'


pega_extensao() {
	export	ext="$(echo "$1" | rev | cut -d . -f 1 | rev)"
	ext_lenght="$( echo "$ext" | wc -m)"
	ext_lenght="$(( "$ext_lenght" + 1))"
	export	nome="$(echo "$1" | rev | cut -b "$ext_lenght"- | rev)"
}

diacriticos() {
	sed s/Ç/c/g |sed s/Õ/o/g |sed s/õ/o/g | sed s/ó/o/g | sed s/â/a/g | sed s/Â/a/g | sed s/ã/a/g |sed s/ñ/n/g | sed s/Ñ/n/g | sed s/é/e/g | sed s/ê/e/g |sed s/Ê/e/g |  sed s/á/a/g | sed s/ú/u/g | sed s/ç/c/g | sed s/Í/i/g | sed s/Õ/o/g | sed s/Ó/o/g | sed s/ö/o/g | sed s/Ö/o/g | sed s/Ã/a/g | sed s/É/e/g | sed s/Á/a/g | sed s/Ú/u/g | sed s/í/i/g | sed s/Í/i/g 
}

regulador() {
	arg="$(cat -)"
	out="$(echo $arg | tr -c 'ΑαΒβΓγΔδΕεΖζΗηΘθΙιΚκΛλΜμΝνΞξΟοΠπΡρΣσ/ςΤτΥυΦφΧχΨψΩωßавеёжкносфухьыэяюшщчцрпийзтмлдгбъАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯqwertyuiopasdfghjklzxcbvnmASDFGHJKLQWERTYUIOPZXCVBNM1234567890.' \_ | sed 's/\ /\_/g' | tr -d '¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿')"
		#tr -d '[\200-\377]')"
	echo "$out"
}

primeiro() {
	arg="$(cat -)"
#	out=$([[ "$(echo $arg | cut -b 1 )" == [0-9A-Za-z] ]] && echo $arg || echo $arg | cut --complement -b 1)
	out="$([ "$(echo "$arg" | cut -b 1 )" == '_' ] && echo "$arg" | cut --complement -b 1 || echo "$arg" )"
	echo "$out"
}

ultimo() {
	arg="$(cat -)"
	out="$([ "$(echo "$arg" | rev | cut -b 1 )" == '_' ] && echo $arg | rev | cut -b 2- | rev  || echo "$arg")"
	echo "$out"
}

underlines() {
	arg="$(cat -)"
	out="$(echo "$arg" | sed 's/\(_\)\1\+/\1/g' | sed 's/\_\./\./g' | sed 's/\.\_/\./g')"
	echo "$out"
}

misc() {
	arg="$(cat -)"
#	out="$(echo "$arg" | tr [:upper:] [:lower:] | sed 's/\ //g' | sed 's/\(.\)\1\+/\1/g' )"
	out="$(echo "$arg" | tr [:upper:] [:lower:] | sed 's/\ //g')"
	echo "$out"
}
for i in "$@"; do
	if [ "$(echo "$i" | grep "\.")" == '' ] 
then
	nome_pre_final="$(echo '_xtemp_'"$i")"
	nome_final="$(echo "$i" | diacriticos | regulador | underlines | primeiro | ultimo )"
	mv "$i" "$nome_pre_final"
	mv "$nome_pre_final" "$nome_final"
else
	pega_extensao "$i"
	# underlines tem q vir antes de ultimo pra evitar de um duplo underline passar adiante
	nome_pre_final="$(echo '_xtemp_'"$(echo "$nome" | diacriticos | regulador | underlines | primeiro | ultimo | misc)"."$(echo $ext | tr [:upper:] [:lower:])")"
	nome_final="$(echo "$nome_pre_final" | sed 's/\_xtemp\_//g')"
#	echo $nome_final
	mv "$i" "$nome_pre_final"
	mv "$nome_pre_final" "$nome_final"
fi
done

# a criacao de um nome_pre_final é necessaria para evitar
# que em sistemas FAT32 ocorra o erro de mover algum arquivo
# que mudou apenas uma letra maiuscula para minuscula
