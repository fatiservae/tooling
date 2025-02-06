#!/bin/sh
sep(){
	terminal_separator -m "$AMBIENTE" -c _ -p $(( $(tput cols)/3 )) -l $(( $(tput cols)/3 )) -x 35 -s 93
}
phr(){
	[ -z "$AMBIENTE" ] && wellcomeascii.sh sep || echo "$AMBIENTE"
}

case $SEL_PROMPT in
separator)
	OUT=$(sep)
;;
phrase)
	OUT=$(phr)
;;
random)
	if [ $(( RANDOM % 3 )) -eq 0 ] && [ $(( RANDOM % 5 )) -eq 0 ]; then # restringe aos múltiplos de 15
		OUT=$(phr)
	else
		OUT=$(sep)
	fi
;;
*)
  echo "Defina o separador como \"random\", \"separator\" ou \"phrase\" e faça \"source ~/.zsh\""
  OUT='

  Defina um prompt!
  
	'
;;
esac
echo "$OUT"
