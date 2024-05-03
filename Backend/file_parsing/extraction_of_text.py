import pytesseract
from PIL import Image
from detection_of_table import TableDetection

image_path = "Backend/file_parsing/cropped_table.png"

tab_detection = TableDetection(image_path)
image = tab_detection.process_pdf()
image = Image.open(image_path)
#bw_image = image.convert("L")
pytesseract.pytesseract.tesseract_cmd = '/opt/homebrew/bin/tesseract'
#config = '--psm 10 --oem 3 -c tessedit_char_whitelist=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZабвгґдеєжзиіїйклмнопрстуфхцчшщьюяАБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'
full_text = pytesseract.image_to_string(image, lang='ukr')

cleaned = full_text.strip()

print(cleaned)
extraction = "Backend/file_parsing/extraction.txt"
with open(extraction,"w",encoding='utf-8') as file:
    file.write(cleaned)

