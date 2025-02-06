/* Jefferson T.
 * Telegrão StalinCCCP - @2023
 * Sem licença, pode copiar pô.
 */
mod args;
use {
  std::io::{self, Read},
  clap::Parser,
  args::Arguments,
  textwrap::{wrap, indent}
};
fn main() -> Result<(), Box<dyn std::error::Error>> {
  let args: Arguments = Arguments::parse();  

  let mut stdin = String::new(); 
  io::stdin().read_to_string(&mut stdin)?;
  let indentation = std::iter::repeat(' ').take(args.padding).collect::<String>();


  let wraped_out = wrap(&stdin, args.lenght);
  for line in wraped_out {
    println!("{}", indent(&line, &indentation)); 
  }
Ok(())
}
