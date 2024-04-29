import pytesseract
from PIL import Image
from detection_of_table import TableDetection

image_path = "/Users/yanakravets/HealthFlow/Backend/file_parsing/photo_2024-04-26 23.42.33.jpeg"

tab_detection = TableDetection(image_path)
image = tab_detection.process_pdf()
image = Image.open(image_path)
#bw_image = image.convert("L")
pytesseract.pytesseract.tesseract_cmd = '/opt/homebrew/bin/tesseract'
#config = '--psm 10 --oem 3 -c tessedit_char_whitelist=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZабвгґдеєжзиіїйклмнопрстуфхцчшщьюяАБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'
full_text = pytesseract.image_to_string(image, lang='ukr+eng')

cleaned = full_text.strip()

print(cleaned)
extraction = "Backend/file_parsing/extraction.txt"
with open(extraction,"w",encoding='utf-8') as file:
    file.write(cleaned)

