pub fn trim_ref(entrada: &str, corte: usize) -> String {
    if corte >= entrada.len() || entrada.is_empty(){
        entrada.to_string()
    }else{
        entrada[corte..].trim_start().to_string()}
}

pub fn remove_spaces(entrada: &str) -> String {
    let s = entrada.to_string();
    s.trim_start().trim_end().to_string();
    return s
}
