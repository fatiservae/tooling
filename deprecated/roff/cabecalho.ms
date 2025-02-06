\" junta autores com argumentos. O 1 diz como juntar dois autores, o segundo como juntar autores "do meio" e o ultimo como juntar os dois últimos 
.R1 
database /mnt/biblioteca/groff/referencias 
capitalize authors 
move-punctuation 
bracket-label \*([. \*(.] ", " 
accumulate 
join-authors " e " ", " " e " 
label %1 
.R2 
\" .ds chama define_strings, usei para mudar a default de REFERENCES, TOC e ABSTRACT. 
.ds REFERENCES Referências 
.ds TOC Índice 
.ds ABSTRACT Resumo
.ds LF ESCS 2022
.ds CF Transtornos mentais e do comportamento
.ds RF Jefferson T.
.nr PO 0.5i \" page offset
.nr LL 7i \" line lenght 
.nr LT 7i \" header/foot lenght
.nr HM 0.5i \" header margin
.nr FM 0.5i \" footer margin
.de ITEM
.IP \[bu] 2
..
