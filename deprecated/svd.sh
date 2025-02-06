#!/bin/bash
# Define quebra de linha
IFS=$'\n';
i=1;
echo "Aguarde confeccionar "$(ls | grep -ie mp4 -ie mkv -ie mov -ie avi | sed s/\.mp4//g | sed s/\.mov//g | sed s/\.avi//g | sed s/\.mkv//g | wc -l)" miniaturas.";
# Loop gera arquivos de video possiveis na pasta
for f in $(ls | grep -ie mp4 -ie mkv -ie mov -ie avi | sed s/\.mp4//g | sed s/\.mov//g | sed s/\.avi//g | sed s/\.mkv//g); 
# Executa gerador de thumbs (thumb_nomedoarquivo) para cada arquivo
	do
		echo "Confeccionando miniatura no."$i"";
	        i=$(( i + 1 ));
		ffmpeg -hide_banner -loglevel error -i $(ls | grep $f) -ss 5 -f image2 -frames:v 1 "thumb_"$f".jpg";

done;

sxiv $(ls | grep thumb) &&

echo -n "Deletar (d) ou mover (m)";
read -e resposta;

case $resposta in
	deletar | d | 1 | apagar | remover | r | D)
# Loop final para executar o comando 'del' que move arquivos selecionados para lixeira
	for g in $(sxiv $(ls | grep thumb) | sed s/\.jpg//g | cut -b 9-);
		do del $(ls | grep $g | grep -v jpg); 
	done
	;;

	mover | m | M)
	echo "Digite destino em caminho absoluto";
	read -e destino;	
	for g in $(sxiv -o $(ls | grep thumb)| sed s/\.jpg//g | cut -b 9-);
		do mv $(ls | grep $g | grep -v jpg) $destino; 
	done
	;;
esac
# Remove todos arquivos usados no script
rm $(ls | grep thumb_); 
exit 

