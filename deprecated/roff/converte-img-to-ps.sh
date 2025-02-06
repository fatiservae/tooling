#!/bin/sh
IFS=$'\n'
pega_extensao() {
		export	ext="$(echo "$1" | rev | cut -d . -f 1 | rev)"
		ext_lenght="$( echo "$ext" | wc -m)"
		ext_lenght="$(( "$ext_lenght" + 1))"
		export	nome="$(echo "$1" | rev | cut -b "$ext_lenght"- | rev)"
	}
for i in "$@"; do
	pega_extensao $i
	convert "$i" "$(echo "$nome"'.ps')"
done
