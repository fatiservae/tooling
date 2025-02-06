#!/bin/bash
IFS=$'\n';
i=1;
# Contar numero de possiveis videos e consequentes miniaturas
echo "Aguarde confeccionar "$(ls | grep -ie mp4 -ie mkv -ie mov -ie avi | sed s/\.mp4//g | sed s/\.mov//g | sed s/\.avi//g | sed s/\.mkv//g | wc -l)" miniaturas.";
# Loop gera miniaturas
for f in $(ls | grep -ie mp4 -ie mkv -ie mov -ie avi | sed s/\.mp4//g | sed s/\.mov//g | sed s/\.avi//g | sed s/\.mkv//g); 
	do
# Executa gerador de thumbs (thumb_nomedoarquivo) para cada arquivo
		echo "Confeccionando miniatura no."$i"";
	        i=$(( i + 1 ));
		ffmpeg -hide_banner -loglevel error -i $(ls | grep $f) -ss 2 -f image2 -frames:v 1 "thumb_"$f".jpg";

done
# Inicia um loop while para retornar caso no fim o usuario queira continuar usando as mesmas thumbs
continuar="s";
while [[ "$continuar" == "s" ]]; do

# Roda o sxiv para que o usuario marque as imagens que quer deletar ou mover
lista=$(sxiv -o $(ls | grep thumb) | sed s/\.jpg//g | cut -b 7-);

echo "Deletar (d) renomear (r) ou mover (m)?";
read resposta;

case $resposta in
# Para executar o comando 'del' que move arquivos selecionados para lixeira
	deletar | d | 1 | apagar | remover | D)
	for g in  $lista;
	do del $(ls | grep "$g" | grep -v jpg);
	rm $(ls | grep "$g" | grep jpg);
	done
	;;
# Para executar o comando 'mv' que move arquivos selecionados para a variavel destino. O mkdir tenta criar o destino primeiro, permitindo criar destinos novos.
	mover | m | M | 2)
	echo "Digite destino em caminho absoluto";
	read -e destino;
	mkdir -p "$destino";
	for k in $lista; do 
	mkdir -p "$destino";
	mv -t $destino $(ls | grep "$k" | grep -v jpg); 
	rm $(ls | grep "$k" | grep jpg);
	done
	;;
# Módulo case para renomear arquivos
	renomear | r | ren | 3 | rename | R)
	for j in $lista; do
	mpv --really-quiet $(ls | grep "$j" | grep -v jpg);
	echo "O arquivo atual é:";
	echo $(ls | grep "$j" | grep -v jpg);
	echo "Digite novo nome para o arquivo:";
	read -e nome;
	mv $(ls | grep "$j" | grep -v jpg) "$nome";
	rm $(ls | grep "$j" | grep jpg);
	done	
	;;
esac
# Rotina de continuar ou não
echo "Deseja continuar?";
read continuar;
done
# Remove todos arquivos usados no script. Os modulos podem ter deletado a miniatura antes e portanto o erro é jogado no null.
rm $(ls | grep thumb_) 2> /dev/null; 
exit 

