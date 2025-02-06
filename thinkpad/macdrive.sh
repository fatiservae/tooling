#!/bin/bash
case $1 in 
	u|-u|umount)
		sudo umount /mnt/macdrive/
	;;
	ul|-ul|-l|lazyu|umountlazy|l)
		sudo umount -l /mnt/macdrive/
	;;
	-h|h|help|ajuda|--help)
		printf 'Monta o drive remoto do MacBook de Jefferson.\n\t-u\tDesmonta.\n\t-l\tDesmonta lazy.\n\t-h\tEsta ajuda.\n'
	;;
	*)
	sudo mount -w 192.168.1.73:/mnt/macdrive/ /mnt/macdrive
	;;
esac
