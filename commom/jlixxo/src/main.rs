use std::env;
use std::fs::{self, Metadata};
use std::path::{Path, PathBuf};
use std::time::SystemTime;
#[allow(non_snake_case)] //use rustc -A non-snake-case para evitar warnings

fn main() {
    let Argumentos: Vec<String> = env::args().collect();
    if Argumentos.len() < 2 {
        println!("Uso: jlixo 'arquivo1' 'arquivo2' 'arquivoN'...");
        return;
    }
    let Destino = match env::var("LIXEIRA") {
        Ok(pasta) => pasta,
        Err(_) => {
            println!("Erro: $LIXEIRA não foi configurada.");
            return;
        }
    };

    if !Path::new(&Destino).exists() {
        println!("Erro: A pasta '{}' não existe.", Destino);
        return;
    }

    // Iterate through the provided files
    for Arquivos in Argumentos[1..].iter() {
        let metadata = match fs::metadata(&Arquivos) {
            Ok(metadata) => metadata,
            Err(err) => {
                println!("Error: Failed to retrieve metadata for file '{}': {}", Arquivos, err);
                continue;
            }
        };

        // Extract the source file's name and extension
        let NomeOriginal = match Path::new(&Arquivos).file_stem() {
            Some(name) => name.to_string_lossy().to_string(),
            None => {
                println!("Error: Invalid file path '{}'", Arquivos);
                continue;
            }
        };

        let Extensao = match Path::new(&Arquivos).extension(){
            Some(ext) => Some(ext.to_string_lossy().to_string()),
            None => None
        };

        let NovoNome = generate_NovoNome(&Destino, &NomeOriginal, &Extensao);
        let NomeDestino = Path::new(&Destino).join(&NovoNome);

        if NomeDestino.exists() {
            println!("Warning: File '{}' already exists in the target folder.", NovoNome);
        }

        // Move the file to the target folder
        match fs::rename(&Arquivos, &NomeDestino) {
            Ok(_) => println!("Movido '{}' para '{}'", Arquivos, NomeDestino.display()),
            Err(err) => println!("Erro: Falhou ao mover '{}' para '{}': {}", Arquivos, NomeDestino.display(), err),
        }

    }
}

fn generate_NovoNome(Destino: &str, NomeOriginal: &str, Extensao: &Option<String>) -> String {
    let Horario = SystemTime::now()
        .duration_since(SystemTime::UNIX_EPOCH)
        .unwrap()
        .as_secs();

    let mut NovoNome = match Extensao {
        Some(ext) => format!("{}_{}.{}", NomeOriginal, Horario, ext), 
        None => format!("{}_{}", NomeOriginal, Horario)
    };

// Check if the generated name conflicts with an existing file
//    let mut counter = 1;
//    while Path::new(&Destino).join(&NovoNome).exists() {
//        NovoNome = format!("{}_{}_{}.{}", NomeOriginal, Horario, counter, Extensao);
//        counter += 1;
//    }

    NovoNome
}
