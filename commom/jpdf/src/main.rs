use poppler::*;
use std::io::{self, Read, Write};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Read input PDF from stdin
    let mut input_pdf = Vec::new();
    // O '?' propaga o possível erro até a fn main() acima.
    // Se for Ok(()), segue o baile.
    io::stdin().read_to_end(&mut input_pdf)?;

    // Open PDF document
    // Usando new_from_file()
    let document = PopplerDocument::new_from_file("/home/arquivo.pdf", "senha");
    let num_pags = document.get_n_pages(); // retorna numero de paginas. Namespace certo?
    let pagina9 = document.get_page(9); // assim retorna uma pg especifica?
    // Find the smallest page width
    let smallest_width = document
        .get_page(5) // pega a pagina que tipo recebe.
        .iter()
        .map(|page| page.page_box().width())
        .fold(f64::INFINITY, f64::min);

    // Create a new PDF document with modified page sizes
    let mut output_pdf = Vec::new();
    let mut pdf_writer = PopplerDocument::PdfWriter::new(&mut output_pdf);
    for page in document.get_page() {
        let mut new_page = Page::new(&mut pdf_writer, page.width(), page.height(), None)?;
        let page_box = page.page_box();
        let (page_width, page_height) = if page_box.width() < smallest_width {
            let scale = page_box.width() / smallest_width;
            (smallest_width, page_box.height() * scale)
        } else {
            (page_box.width(), page_box.height())
        };
        let new_page_box = Rect::new(0.0, 0.0, page_width, page_height);
        new_page.set_crop_box(&new_page_box);
        new_page.set_media_box(&new_page_box);
        new_page.render(page)?;
    }

    // Write modified PDF to stdout
    io::stdout().write_all(&output_pdf)?;

    Ok(())
}

