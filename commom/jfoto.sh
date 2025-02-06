#!/bin/bash
# By Jefferson T.
# Um manipulador de filename e destino para fotos
# usando sxiv

IFS=$'\n';
a="s";
continua='s'
# Inicia o loop while pra permanecer até o usuario querer sair
while [[ "$continua" == "s" ]]; do

# Gera lista de fotos a serem manipuladas 
lista=$(sxiv -o .);
# Bloco de saída para fim dos arquivos possíveis de serem listados
if [[ "$lista" == "" ]] 
	then 
		echo "Fim dos arquivos. Saindo..." 
		exit;
fi
echo "Deseja deletar (d), mover para lixeira (l), renomear (r), mover (m) ou sair (s)?";
read resposta;

# Módulos de manipulação
case "$resposta" in

# Modulo mover
	m)
	echo "Digite destino em caminho absoluto:";
	read -e caminho;
	echo "Aguarde...";
	mkdir -p "$caminho";
	mv -t "$caminho" $lista;
	;;

# Modulo lixeir 
	l)
	del $lista;
	echo "Aguarde...";
	;;
# Modulo deletar
	d)
	rm $lista;
	echo "Aguarde...";
	;;
# Modulo sair
	s | sair | exit)
	exit;
	;;
# Modulo renomear
	r | renomear | R)
	for r in $lista; 
	do sxiv $r && echo $r && echo "Digite novo nome"; read nn && mv -i $r $nn;
	done
	;;
esac
echo "Continuar? (s) (n)";
read continua;
done
exit
