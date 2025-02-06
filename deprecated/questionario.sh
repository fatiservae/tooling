#!/bin/sh
# Jefferson 2021 
# Telegrão @StalinCCCP

# Como funciona: um arquivo de questões deve ser passado ao programa para que ele apresente ao usuário a pergunta de forma aleatória, seguida da resposta após 'Enter'
# toda questão é composta de duas linhas, uma primeira que é pergunta e uma segunda que é resposta

#  ----------------


# define a variavel n como vazia para manter o loop
base=$(echo $1 | grep .)
n='';

while [ "$n" = '' ];
do
# a variavel sorteio tem como resultado um numero sorteado, que sera usado como número de questão.
sorteio="$(shuf -i 1-"$(awk END'{print FNR / 2}' $base)" | awk 'NR == 1' )";

# tendo em vista que o arquivo contem sempre um número dobrado de linhas para o número de questões, a variavel pergunta dá o numero da linha em que estará a pergunta da questão sorteada
pergunta=$(( ($sorteio - 1 ) * 2  + 1 ));
printf 'PERGUNTA\n';
awk -v LINHA=$pergunta ' NR == LINHA' $base;

# um read vazio apenas pausa o código até que a pessoa responda a pergunta. Ao dar 'enter' o código segue dando o gabarito (resposta)
read p;

# tendo em vista que o arquivo contem sempre um número dobrado de linhas para o número de questões, a variavel resposta dá o numero da linha em que estará a resposta da questão sorteada
resposta=$(( ($sorteio - 1 ) * 2  + 2 ));
printf 'RESPOSTA\n';
awk -v LINHA=$resposta ' NR == LINHA' $base;

# para manter o loop, basta dar enter que o sorteio é feito novamente, já que a variavel 'n' continua vazia. Qualquer outra resposta dá exit
printf '\nContinuar? Enter ou (s)air.\n';
read n;
done

exit
