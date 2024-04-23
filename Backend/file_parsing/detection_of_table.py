import fitz
from transformers import DetrImageProcessor, DetrForObjectDetection
from PIL import Image
import torch

class TableDetection:
    def __init__(self, pdf_file_path):
        self.pdf_file_path = pdf_file_path
        self.processor = DetrImageProcessor.from_pretrained("TahaDouaji/detr-doc-table-detection")
        self.model = DetrForObjectDetection.from_pretrained("TahaDouaji/detr-doc-table-detection")

    def process_pdf(self):
        pdf_document = fitz.open(self.pdf_file_path)
        cropped_images = []
        for page_number in range(len(pdf_document)):
            page = pdf_document[page_number]
            pixmap = page.get_pixmap(matrix=fitz.Matrix(300/72, 300/72), alpha=False)
            image = Image.frombytes("RGB", [pixmap.width, pixmap.height], pixmap.samples)
            cropped_image = self.process_image(image)  # Передача зображення у метод process_image
            cropped_images.append(cropped_image)
        pdf_document.close()
        return cropped_images

    def process_image(self, image):
        max_image_size = (4096, 4096)# Визначте максимальний розмір зображення
        image.thumbnail(max_image_size, Image.BICUBIC)
        
        inputs = self.processor(images=image, return_tensors="pt")
        with torch.no_grad():
            outputs = self.model(**inputs)

        width, height = image.size

        results = self.processor.post_process_object_detection(outputs, threshold=0.6, target_sizes=[(height, width)])[0]
        x_min, y_min, x_max, y_max = results['boxes'][0].tolist()
        
        top_margin = 20
        bottom_margin = 30
        left_margin = 200
        right_margin = 40

        x_min = max(0, x_min - left_margin)
        y_min = max(0, y_min - top_margin)
        x_max = min(width, x_max + right_margin)
        y_max = min(height, y_max + bottom_margin)

        crop_img = image.crop((x_min, y_min, x_max, y_max))
        print("Original coordinates:", x_min, y_min, x_max, y_max)
        print("Image width:", width)
        print("Image height:", height)

        cropped_image_path = "/Users/yanakravets/HealthFlow/Backend/file_parsing/cropped_table.png"
        crop_img.save(cropped_image_path)
        return cropped_image_path
    
