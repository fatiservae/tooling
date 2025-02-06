import sys
from PyPDF2 import PdfReader
from PyPDF2.generic import DictionaryObject, StreamObject
from PIL import Image

def extract_images_from_pdf(pdf_path):
    images = []

    with open(pdf_path, 'rb') as file:
        reader = PdfReader(file)

        for page_num in range(len(reader.pages)):
            page = reader.pages[page_num]
            if '/XObject' in page['/Resources']:
                x_objects = page['/Resources']['/XObject'].get_object()
                for obj_name in x_objects:
                    obj = x_objects[obj_name]
                    if obj['/Subtype'] == '/Image':
                        if isinstance(obj, StreamObject):
                            width = obj['/Width']
                            height = obj['/Height']
                            bits_per_component = obj['/BitsPerComponent']
                            color_space = obj['/ColorSpace']
                            data = obj._data  # Dados brutos da imagem
                            image = Image.frombytes(color_space, (width, height), data)
                            images.append(image)
    
    return images

# Exemplo de uso
pdf_path = "prova-A.pdf" 
image_list = extract_images_from_pdf(pdf_path)

# Exibir informações sobre as imagens
for i, image in enumerate(image_list):
    print(f"Imagem {i + 1}:")
    print(f"Largura: {image.width}")
    print(f"Altura: {image.height}")
    print(f"Modo de cor: {image.mode}")
    print()

# Obtém o caminho do arquivo PDF a partir do primeiro argumento

# Obtém o diretório atual
current_directory = os.getcwd()

# Extrai o texto do PDF
output_folder = extract_text_from_pdf(pdf_path, current_directory)

print("Extração concluída.")
