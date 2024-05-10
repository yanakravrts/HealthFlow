import pytesseract
from PIL import Image
from detection_of_table import TableDetection

file_path = '/Users/yanakravets/HealthFlow/Backend/file_parsing/womananalysis.pdf'
pdf_processor = TableDetection(file_path)
cropped_images= pdf_processor.process_pdf()

for image in cropped_images:
    temp_image_path = "/Users/yanakravets/HealthFlow/Backend/file_parsing/temp_image.png"
    image.save(temp_image_path)

new_size = (600, 600)
image = Image.open(temp_image_path)
image.thumbnail(new_size)
bw_image = image.convert("L")

pytesseract.pytesseract.tesseract_cmd = '/opt/homebrew/bin/tesseract'
full_text = pytesseract.image_to_string(image, lang='ukr+eng')
cleaned = full_text.strip()

print(cleaned)
extraction = "Backend/file_parsing/extraction.txt"
with open(extraction,"w",encoding='utf-8') as file:
    file.write(cleaned)
