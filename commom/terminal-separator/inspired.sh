#!/bin/sh
build_padd() {
  result=""
  for ((i=0; i<$1; i++)); do
    result+=" "
  done
  #echo $result | cat -A
  printf "%s\n" "$result" 
}

build_half() { #$1 é o lenght e $2 o char
  for ((i=0; i<$1; i++)); do
    result+="$2"
  done
  echo $result
}

char=$1
#[ -z $1 ] && echo "Verifique argumentos!" && exit
#[ "$2" -gt 0 ] && lenght="$2" || echo "Verifique comprimento!" && exit
#[ "$3" -gt 0 ] && padlen="$3" || echo "Verifique padding!" && exit
#[ -z $4 ] && echo "Excesso de argumentos" && exit
lenght=$(( $(tput cols) / 6 ))
padlen=$(( $(tput cols) / 3  ))
padding=$(build_padd $padlen)
half=$(build_half $lenght $char)

echo -e "\033[38;5;203m$padding$half$char$half\033[0m"
