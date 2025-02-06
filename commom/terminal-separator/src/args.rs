use clap::{
  //Args,
  Parser,
  //Subcommand
};

#[derive(Debug, Parser)]
#[clap(author, version, about)]
pub struct Arguments{
  /// Caractere que vai ser repetido como separador.
  pub character: char,
  /// Padding em número de colunas.
  pub padding: usize,
  /// Mensagem embutida no separador. 
  ///
  /// Normalmente, atribui-se o valor da variável global $AMBIENTE.
  pub message: String,
  /// Comprimento do separador.
  pub lenght: usize,
  //TODO: Implementar código de cor como argumento.
}
