#!/bin/sh
j=$(( $(tput cols) * 3 / 4 ))
case $1 in
	-ask)
		echo "Entre caminho da base:"
		read -r caminho
		< "$caminho" jref ${@:2} | wrapeador $j 5
;;
	-nowrap)
		< /mnt/biblioteca/base.jref jref ${@:2}
;;
	*)
		< /mnt/biblioteca/base.jref jref $@ | wrapeador $j 4
;;
esac
