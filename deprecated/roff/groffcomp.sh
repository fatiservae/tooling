#!/bin/bash
case $1 in
	h | help)	
echo -e "nome do arquivo\nformato de saida\nformato groff entrada"
;;
	*)
cat "$1" | /mnt/biblioteca/groff/latinchar | refer | /mnt/biblioteca/groff/latinchar | groff -$3 -tbl -p -T"$2" > "$(echo "$1" | rev | cut -d . -f 2,3,4,5,6 | rev)"."$2";
;;
esac
