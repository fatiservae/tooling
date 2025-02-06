#!/bin/sh
case $1 in
g)
	tamanho=$(grep "$1" ~/.symbols_ascii.md | awk '{print $2}')
	grep -A"$tamanho" "$1" ~/.symbols_ascii.md | grep -v "$1"
;;
sep)
	i=0; while IFS= read -r; do	i=$((i + 1)); done < ~/.quotes
	sorteio() {
		quote="$(sed -n "$(shuf -i 0-"$i" --head-count=1)"p ~/.quotes)"
	}
	sorteio 
	while [ "$quote" = '' ]; do sorteio; done
	j=$(( $(tput cols) / 3 ))
	printf '\n'
	echo "$quote" | wrapper -l "$j" -p "$j" 
;;
*)
	i=0; while IFS= read -r; do	i=$((i + 1)); done < ~/.quotes
	sorteio() {
		quote="$(sed -n "$(shuf -i 0-"$i" --head-count=1)"p ~/.quotes)"
	}
	sorteio 
	while [ "$quote" = '' ]; do sorteio; done
	j=$(( $(tput cols) / 2 ))
	printf '\n'
	echo "$quote" | wrapper -l $j -p 10
;;
esac
