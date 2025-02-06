/* StalinCCCP - Telegrão e leftpol
 * Sem licença, pode copiar pô.
 * @2022
 *
 * Este prgrama faz parte de minha library pessoal para manipular
 * fluxo de dados via terminal ou interfaces gráficas padronizadas
 * para um OS meu. 
 *
 * V1384
 * Este source transforma entradas de texto em for-
 * matação padrão de linhas em aproximadamente 60 caracters para
 * amostragem em terminais suckless.
 */

use std::io::{self, BufRead};

fn main() {
    // stdin lê a entrada usando o crate io
let stdin = io::stdin();
    // loop for para ler cada linha passada como entrada padrão
for entrada in stdin.lock().lines() {
    // handle de erro
  let entrada = entrada.expect("Não foi possível ler entrada");
    // saida é a variavel que transformou entrada em um vetor
  let saida: Vec<char> = entrada.chars().collect();
    // i é o primeiro contador, que marca inicio de linhas
  let mut i = 0;
        while saida.len() - i > 60 {
            // j é um contador que marca incremento de caracter até encontrar um espaço ' '
            let mut j = 0;
        while saida[i+60] != ' ' {
        i = i + 1;
        j = j + 1;
        }
        i = i - j;
        // imprime a linha formatada até achar um espaço
           let linha: String = saida[i..60+j+i].iter().collect::<String>();
           println!("         {}", &linha);
            i = i + 60 + j;
        };
        // imprime o que restar de linha
           let linha: String = saida[i..].iter().collect::<String>();
           println!("         {}", &linha);
       };
}
