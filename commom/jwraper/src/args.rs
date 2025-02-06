use clap::Parser;
     
#[derive(Debug, Parser)]
#[clap(author, version, about)]
/// Constrói as regras de wraping e padding de strings livres 
/// no terminal.
///
/// Exemplo: 
/// `$ echo 'Um estringue longa para teste | wrapper -l 20 -p 3`
///
/// Vai ter de output:
///
///`   Um estringue 
///    longo para 
///    teste`
///
/// Repare que apesar do comprimento 20, as palavras não são 
/// quebradas.
///
/// TODO: Implementar quebras justificadas, retas e em colunas.
pub struct Arguments{
  /// Comprimento máximo. Normalmente uma fração de `tput cols`.
  #[arg(short, long)]
  pub lenght: usize,
  /// Padding.
  #[arg(short, long)]
  pub padding: usize,
}
