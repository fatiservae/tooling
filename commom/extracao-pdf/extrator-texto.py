import sys
import os
import PyPDF2

def extract_text_from_pdf(pdf_path, output_folder):
    pdf_name = os.path.splitext(os.path.basename(pdf_path))[0]
    output_folder = os.path.join(output_folder, pdf_name)
    os.makedirs(output_folder, exist_ok=True)
    output_file = os.path.join(output_folder, f"{pdf_name}.txt")

    with open(pdf_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        text = ""
        for page in reader.pages:
            text += page.extract_text()

    with open(output_file, 'w', encoding='utf-8') as output:
        output.write(text)

    return output_folder

# Verifica se foi fornecido o caminho para o arquivo PDF
if len(sys.argv) < 2:
    print("Você precisa fornecer o caminho para o arquivo PDF.")
    sys.exit(1)

# Obtém o caminho do arquivo PDF a partir do primeiro argumento
pdf_path = sys.argv[1]

# Obtém o diretório atual
current_directory = os.getcwd()

# Extrai o texto do PDF
output_folder = extract_text_from_pdf(pdf_path, current_directory)

print("Extração concluída.")
