mod args;
use args::Arguments;
use clap::Parser;

fn main() {
    let args: Arguments = Arguments::parse();
    let mut separator: Vec<char> = Vec::new();
    let half_len = args.lenght - args.message.len();
    for _ in 0..args.padding {
        separator.push(' ');
    }
    for _ in 1..half_len {
        separator.push(args.character);
    }
    args.message
        .chars()
        .collect::<Vec<char>>()
        .iter()
        .for_each(|x| separator.push(*x));
    for _ in 1..half_len {
        separator.push(args.character);
    }
    println!("{}", separator.iter().collect::<String>());
}
