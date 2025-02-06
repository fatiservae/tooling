# jRef - anotações e referências Unix-like
Um sistema simples de montar anotações referenciadas.

## Instalação
Clone o repositório e mova o `jRef` e `./target/jref` para um $PATH:
```
$ cp vim/ftdetect/jref.vim ~/.vim/ftdetect/ && cp vim/syntax/jref.vim ~/.vim/syntax/
```

Edite o script `jRef` se necessário.

## Uso
Em um arquivo de texto simples, faça anotações separadas por linha em branco. Salve com a extensão `.jref`.
Use as âncoras `::ref` `::loc` e `::lnk` nas linhas sequentes à anotação, assim:
```
Esta é uma anotação interessante sobre Diabetes Mellitus na página 20.
Esta é uma outra anotação sobre Diabetes Mellitus na página 24.
::ref AUTOR, Nome. Título do artigo ou livro. 2050. Editora. Cidade.
::loc /home/user/artigo.pdf
::lnk http://www.referencia.foo.br
```
Chame o `jRef` usando standart input como streaming de entrada e os argumentos como termo da busca. Os termos podem ser separados por vírgula para busca composta:
```
$ cat '/caminho/para/uma-base-qualquer.jref' | jRef 'anotacao, interessante'
```
Ou no uso de arquivo único indicado pelo script `jRef` (edite o script para indicar o arquivo `.jref` desejado):

```
jRef 'diabetes anotacao interess'
```
Ambos exemplos resultará:
```
Esta é uma anotação interessante sobre Diabetes Mellitus na página 20.
Referência: AUTOR, Nome. Título do artigo ou livro. 2050. Editora. Cidade.
Localização: /home/user/artigo.pdf
Link: http://www.referencia.foo.br
```

O sistema tolera palavras incompletas, buscas de múltiplos termos e referências sem notas.

## Racional
JSON é lento, parses utilizam bibliotecas exageradamente grandes e todos sistemas de referências bibliográficas atuais são *overengineereds*.

## Abstração
As âncoras são lançadas em direção ao fundo de cada nota. O fundo é uma linha em branco.

```
↓ Uma nota qualquer.
↓ Outra.
↓ Mais uma.
⚓::ref Âncora jogada no fundo da nota.
⚓::lin https://www.referenciadanota.com "Outra âncora jogada no fundo."

↓ Início de outra nota. A linha em branco acima é o fundo da nota anterior.
↓ As setas para baixo indicam o sentido da busca do MedBase.
⚓::ref Âncora jogada no fundo da nota.
⚓::lnk https://www.referenciadanota.com "Outra âncora jogada no fundo."

```
## Vim
A sintaxe vim fornecida enfeita `âncoras`, comentários iniciados por `#` e anotações de páginas.

## Licença
> Copyright (c) 2022 - Jefferson T. 
> This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>
