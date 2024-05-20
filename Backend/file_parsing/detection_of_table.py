import fitz
from transformers import DetrImageProcessor, DetrForObjectDetection
from PIL import Image
import torch

class TableDetection:
    """
    A class for detecting tables in PDF documents and extracting them as images.

    Attributes:
        pdf_file_path (str): The path to the PDF file.
        processor (DetrImageProcessor): The image processor model for preprocessing images.
        model (DetrForObjectDetection): The object detection model for detecting tables.
    """

    def __init__(self, pdf_file_path):
        """
        Initializes the TableDetection object with the path to the PDF file and loads the required models.

        Args:
            pdf_file_path (str): The path to the PDF file.
        """
        self.pdf_file_path = pdf_file_path
        self.processor = DetrImageProcessor.from_pretrained("TahaDouaji/detr-doc-table-detection")
        self.model = DetrForObjectDetection.from_pretrained("TahaDouaji/detr-doc-table-detection")

    def process_pdf(self):
        """
        Processes the PDF document to detect tables and extract them as images.

        Returns:
            list: A list of cropped table images.
        """
        pdf_document = fitz.open(self.pdf_file_path)
        cropped_images = []
        for page_number in range(len(pdf_document)):
            page = pdf_document[page_number]
            pixmap = page.get_pixmap(matrix=fitz.Matrix(300/72, 300/72), alpha=False)
            image = Image.frombytes("RGB", [pixmap.width, pixmap.height], pixmap.samples)
            image = image.resize((2480, 3508)) 
            cropped_image = self.process_image(image)  
            cropped_images.append(cropped_image)
        pdf_document.close()
        return cropped_images

    def process_image(self, image):
        """
        Processes an image to detect and crop the table.

        Args:
            image (PIL.Image.Image): The input image containing the table.

        Returns:
            PIL.Image.Image: The cropped table image.
        """
        max_image_size = (4096, 4096)  
        image.thumbnail(max_image_size, Image.BICUBIC)
        
        inputs = self.processor(images=image, return_tensors="pt")
        with torch.no_grad():
            outputs = self.model(**inputs)

        width, height = image.size

        results = self.processor.post_process_object_detection(outputs, threshold=0.3, target_sizes=[(height, width)])[0]
        
        x_min, y_min, x_max, y_max = 0, 0, width, height 

        if 'boxes' in results and len(results['boxes']) > 0:
            x_min, y_min, x_max, y_max = results['boxes'][0].tolist()
            
            top_margin = 20
            bottom_margin = 30
            left_margin = 100
            right_margin = 40

            x_min = max(0, x_min - left_margin)
            y_min = max(0, y_min - top_margin)
            x_max = min(width, x_max + right_margin)
            y_max = min(height, y_max + bottom_margin)
        
        else:
            print("No objects")
        
        crop_img = image.crop((x_min, y_min, x_max, y_max))   
        cropped_image_path = "/Users/yanakravets/HealthFlow/Backend/file_parsing/cropped_table.png"
        crop_img.save(cropped_image_path)
        return crop_img
