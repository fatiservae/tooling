/*
* Copyright (c) 2023 - Jefferson T.
* Telegrão @StalinCCCP
* This program is free software: you can redistribute it and/or modify it under 
* the terms of the GNU General Public License as published by the Free Software 
* Foundation, either version 3 of the License, or (at your option) any later 
* version. This program is distributed in the hope that it will be useful, but 
* WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
* more details. You should have received a copy of the GNU General Public 
* License along with this program.  If not, see <https://www.gnu.org/licenses/> 
*/

extern crate diacritics;
mod entrada;
mod trims;
use {
    regex::Regex,
    entrada::*,
    trims::*,
    diacritics::*,
};

fn main() {
let linhas: Vec<String> = entrada();
let termos = prompt();

let refer = Regex::new(&format!(r"::ref")).unwrap();
let link = Regex::new(&format!(r"::lnk")).unwrap();
let local = Regex::new(&format!(r"::loc")).unwrap();
let tags = Regex::new(&format!(r"::tag")).unwrap();
let comentario = Regex::new(&format!("^#.")).unwrap();


struct Nota {
    referencias: Vec<String>,
    anotacoes: Vec<String>,
    local: String,
    links: Vec<String>,
    tags: Vec<String>,
    query: usize 
}
let mut i: usize = 1;
let mut saida: Vec<Nota> = vec![
    Nota{referencias: Vec::new(), anotacoes: Vec::new(), local: String::new(), links: Vec::new(), tags: Vec::new(), query: 0}]; 

    /* A lógica OR é melhor para a busca. 
     * Seria possível usar lógica AND e
     * fazer a busca em ciclos filtrando
     * seguidas vezes o vetor 
     * saida<Vec<Nota>>
    */
let no_termos = termos.len() - 1;

for mut termo in termos {
    termo = termo.to_lowercase();
    linhas.iter().rev().for_each(|linha|
     if linha.is_empty(){
         let nova_nota = Nota {
             referencias: vec![],
             anotacoes: vec![],
             links: vec![],
             tags: vec![],
             local: String::new(),
             query: 0
         };
         saida.push(nova_nota);
         i = i + 1;}
     else if refer.is_match(&linha) {
         saida[i-1].referencias.push(linha.to_string());}
     else if tags.is_match(&linha) {
         saida[i-1].tags.push(linha.to_string());}
     else if local.is_match(&linha) {
         saida[i-1].local = linha.to_string();}
     else if comentario.is_match(&linha) {}
     else if link.is_match(&linha) {
         saida[i-1].links.push(linha.to_string());}
     else if remove_diacritics(linha).to_lowercase().contains(&remove_diacritics(&termo)){
        // || remove_diacritics(&linha.to_lowercase()).contains(&termo) || linha.to_lowercase().contains(&remove_diacritics(&termo)){
         saida[i-1].anotacoes.push(linha.to_string());
         saida[i-1].query += 1;
     });
}
//println!("{}", no_termos);
for nota in saida{
//println!("{}", nota.query);
    if nota.query >= no_termos {
        for (index, anotacao) in nota.anotacoes.iter().enumerate() {
            println!("\x1b[32;1mAnotação {}: \x1b[0m\x1b[0m{}\x1b[0m", index+1, anotacao);
        }
        for referencia in nota.referencias {
            println!("\x1b[33;1mReferência: \x1b[0m\x1b[0m{}\x1b[0m", trim_ref(&referencia, 5));
        }
        for link in nota.links{
            println!("\x1b[31;1mLink: \x1b[0m\x1b[0m{}\x1b[0m", trim_ref(&link, 5));
        }
    println!("\x1b[34;1mTags: \x1b[0m\x1b[0m{}\x1b[0m", trim_ref(&nota.tags.join(" "), 5));
    println!("\x1b[31;1mLocal: \x1b[0m\x1b[0m{}\x1b[0m", trim_ref(&nota.local, 5));
    println!("- - -\n")
    }
}
}
