use {    std::io::{self},
         std::env,
};

/* Entrada como stdin */
pub fn entrada() -> Vec<String> {
   io::stdin()
        .lines()
        .map(|line| line.expect("🤪 Não transformou em linhas!"))
        .collect()
}

/* Segundo argumento como prompt de usuário */
pub fn prompt() -> Vec<String>{
    let args: Vec<String> = env::args().collect();
    return args

/* Antigo código para considerar apenas o primeiro argumento
*    if args.len() != 2 {
*       println!("\x1b[31;1;5mATENÇÃO:\n Insira toda busca como argumento único! 😠\x1b[0m");
*    }
*
*    let argumento = &args[1];
*    let termos: Vec<String> = argumento.to_string().split(",").map(|num| num.parse::<String>().unwrap()).collect();
*/ 
}
