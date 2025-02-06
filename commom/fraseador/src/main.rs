use std::fs::File;
use std::env;
use std::process::exit;
use std::io::{BufRead, BufReader, Result, Write};
use rand::{thread_rng, Rng};
use std::time::{/*SystemTime, */Duration};

fn main() -> Result<()> {
  let args: Vec<String> = env::args().collect();
  if args.len() < 3{
    println!("Uso: \nfraseador [DURAÇÃO DA FRASE] [INTERVALO MÁXIMO DE TEMPO]\n\nO intervalo máximo de tempo é o maior tempo possível entre frases.\nA seleção do intervalo é aleatória.\nTodos os tempos em segundos.");
    exit(1)}
  let duracao = args[1].parse::<u64>()
                       .expect("Erro na leitura do argumento duração."); 
  let intervalo_max = args[2].parse::<u64>()
                             .expect("Erro na leitura do argumento intervalo máximo."); 
  let entrada_path = "/home/jefferson/.frases"; 
  let saida_path = "/home/jefferson/.avisos";
  let reader = BufReader::new(File::open(entrada_path)?);
  
  let lines = reader.lines().collect::<Result<Vec<String>>>()?;
  let mut rng = thread_rng();
  
  
  let random_delay = rng.gen_range(0..intervalo_max);
  
  loop {
    let random_index = rng.gen_range(0..lines.len());
        /* saida é definida dentro
         * do loop para sobrescrever
         * o arquivo */
    let mut saida = File::create(saida_path)?;
    saida.write(lines[random_index].as_bytes())?;
    std::thread::sleep(Duration::from_secs(duracao));
    saida = File::create(saida_path)?;
    saida.write_all(b"")?;
    
    std::thread::sleep(Duration::from_secs(random_delay));
  }
}
