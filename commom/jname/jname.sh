#!/bin/bash
# ~~ memento mori ~~
# Telegrão: @StalinCCCP 
# @2023
# Jefferson T.

helper() {
	printf 'Jname - um cleaner de filenames estúpido!\nTelegrão:StalinCCCP @ 2023\n\nFlag\tOpção\n\n-h\tAjuda.\n-l\tTransforma para minúsculas.\n-r\tElimina separadores repetidos.\n-e\tElimina caracters estranhos.\n-m\tTransforma em CamelCase.\n-x\tSepara CamelCase.\n-d\tElimina diacríticos.\n-s\tElimina espaços.\n-p\tElimina pontos.\n-u\tElimina não printáveis.\n\nEste software é livre.\nJefferson T.\n'
	exit
}

IFS=$'\n'
if [[ "$1" =~ ^-.* ]]; then
	[[ "$1" == '-h' ]] && helper
	argumentos="$(echo "$1"|cut -c 2-)"
	arquivos=("${@:2}")
else 
	argumentos=""
	arquivos=("$@")
fi
pega_extensao() {
	ext="$(echo "$1" | rev | cut -d . -f 1 | rev | tr '[:upper:]' '[:lower:]')"
	ext_lenght=${#ext}
	ext_lenght="$(( "$ext_lenght" + 1))"
	nome="$(echo "$1" | rev | cut -b "$ext_lenght"- | rev)"
	export nome ext
}

for arquivo in "${arquivos[@]}"; do
	if [[ "$arquivo" =~ \..{1,5}$ ]]; then
		pega_extensao "$arquivo"	
		prefinal=('_jname_temp_'"$(echo "$nome" | eval "normalizador $argumentos").$ext")
		final=$(echo $prefinal | sed 's/\_jname_temp\_//g');
		# duplo mv previne sistemas FAT32 de impossibilitar mover
		mv "$arquivo" "$prefinal" && mv "$prefinal" "$final"
	else
		prefinal=('_jname_temp_'"$arquivo")
		final=$(echo "$arquivo" | eval "normalizador $argumentos")
		# duplo mv previne sistemas FAT32 de impossibilitar mover
		mv "$arquivo" "$prefinal" && mv "$prefinal" "$final"
	fi
done
