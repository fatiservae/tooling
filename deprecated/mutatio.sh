#!/bin/sh
msg(){
	echo "Conectado em $1: $2" | tee ~/.avisos
	sleep 5
	>~/.avisos
}

rede() {
	iwctl station wlan0 show | grep 'Connected network' | awk '{print $3}'
}

address(){
	sleep 1
	ip=
	while [ "$ip" == '' ]; do 
		ip=$(ip -p address | awk '/wlan0/' | awk 'NR==2{print $2}')
	done
	echo "$ip"
}

_scan(){
	iwctl station wlan0 scan
}

_restart(){
	# A ordem de reinício de DHCP depois IWD deve ser 
	# respeitada.
	sudo systemctl restart dhcpcd.service && 
  sudo systemctl restart iwd.service
}

case $1 in
	-h|h|--help|help|-help|ajuda|-ajuda|--ajuda)
		printf "Mutatio retorna a rede atual e o IP. \n
    Demais usos:\n\t-s\tTroca entre REDE1 e REDE2.\n
    \t-c\tConecta em nova rede:\n
    \t\tmutatio.sh -c 'NomeDaRede' 'SenhaDaRede'\n"
;;
	r|-r|restart|reset|-restart|-reset|--restart|--reset)
		_restart &&
    nome=$(rede) && ip=$(address) && msg "$nome" "$ip"
;;
	-s|switch|trocar|troca|-troca|-trocar|s)
		$(_scan) && sleep 1
		if [ "$(rede)"  != 'REDE1' ]; then 
			iwctl station wlan0 connect REDE1
		elif [ "$(rede)" == 'REDE1' ]; then
			iwctl station wlan0 connect REDE2
		else 
			echo 'Rede atual desconhecida'
		fi
    nome=$(rede) && ip=$(address) && msg "$nome" "$ip"
;;
	-c|conectar|-conectar|--conectar|connect|-connect|--connect)
    $(_scan) &&
    if [ -z "$2" ]; then
      printf "Faltou argumentos:\n
        \tmutatio.sh -c 'nome da rede' 'senha'\n
        \t A senha é opcional." && 
      exit
    elif [ "$3" != '' ]; then
		  iwctl --passphrase="$3" station wlan0 connect "$2"
    else 
		  iwctl station wlan0 connect "$2"
		  #sleep 3 && 
    fi
    nome=$(rede) && ip=$(address) && msg "$nome" "$ip"
;;
	*)
    nome=$(rede) && ip=$(address) && msg "$nome" "$ip"
;;
esac
