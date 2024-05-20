import numpy as np
from PIL import Image
from detection_of_table import TableDetection
from transformers import TableTransformerForObjectDetection, DetrFeatureExtractor
import matplotlib.pyplot as plt
import os

class TableRecognition:
    """
    A class for recognizing the structure of tables in an image using Transformer-based object detection.

    Attributes:
        image_path (str): The path to the image file.
        feature_extractor (DetrFeatureExtractor): The feature extractor model for image preprocessing.
        model (TableTransformerForObjectDetection): The Transformer-based model for table structure recognition.
        COLORS (list): A list of RGB colors for visualization.
    """

    def __init__(self, image_path):
        """
        Initializes the TableRecognition object with the image path and loads the required models.

        Args:
            image_path (str): The path to the image file.
        """
        self.image_path = image_path
        self.feature_extractor = DetrFeatureExtractor.from_pretrained("facebook/detr-resnet-50")
        self.model = TableTransformerForObjectDetection.from_pretrained("microsoft/table-transformer-structure-recognition")
        self.COLORS = [[0.000, 0.447, 0.741], [0.850, 0.325, 0.098], [0.929, 0.694, 0.125],
                       [0.494, 0.184, 0.556], [0.466, 0.674, 0.188], [0.301, 0.745, 0.933]]

    def plot_results(self, pil_img, scores, labels, boxes, rows=None, columns=None):
        """
        Plots the results of table structure recognition on the input image.

        Args:
            pil_img (PIL.Image.Image): The PIL image object.
            scores (torch.Tensor): Confidence scores for each predicted box.
            labels (torch.Tensor): Predicted class labels for each box.
            boxes (torch.Tensor): Bounding boxes (xmin, ymin, xmax, ymax) for each box.
            rows (list): List of tuples representing row coordinates.
            columns (list): List of tuples representing column coordinates.
        """
        plt.figure(figsize=(16,10))
        plt.imshow(pil_img)
        ax = plt.gca()
        colors = self.COLORS * 100
        for score, label, (xmin, ymin, xmax, ymax), c in zip(scores.tolist(), labels.tolist(), boxes.tolist(), colors):
            if score < 0.75:
                continue
            ax.add_patch(plt.Rectangle((xmin, ymin), xmax - xmin, ymax - ymin, fill=False, color=c, linewidth=3))
            text = f'{self.model.config.id2label[label]}: {score:0.2f}'
            ax.text(xmin, ymin, text, fontsize=15, bbox=dict(facecolor='yellow', alpha=0.5))

        if rows:
            for y_min, y_max in rows:
                ax.axhline(y=y_min, color='r', linestyle='-')
                ax.axhline(y=y_max, color='r', linestyle='-')

        if columns:
            for x_min, x_max in columns:
                ax.axvline(x=x_min, color='g', linestyle='-')
                ax.axvline(x=x_max, color='g', linestyle='-')
        plt.axis('off')
        plt.show()

    def get_row_and_column_coordinates(self, boxes):
        """
        Extracts row and column coordinates from predicted bounding boxes.

        Args:
            boxes (torch.Tensor): Bounding boxes (xmin, ymin, xmax, ymax) for each box.

        Returns:
            rows (list): List of tuples representing row coordinates.
            columns (list): List of tuples representing column coordinates.
        """
        rows = [(box[1].detach().numpy(), box[3].detach().numpy()) for box in boxes]
        columns = [(box[0].detach().numpy(), box[2].detach().numpy()) for box in boxes]
        return rows, columns

    def recognize_table_structure(self):
        """
        Recognizes the structure of the table in the image and visualizes the results.
        """
        print("Recognizing table structure...")
        image = Image.open(self.image_path)
        encoding = self.feature_extractor(image, return_tensors="pt")
        outputs = self.model(**encoding)
        target_sizes = [image.size[::-1]]
        results = self.feature_extractor.post_process_object_detection(outputs, threshold=0.6, target_sizes=target_sizes)[0]
        rows, columns = self.get_row_and_column_coordinates(results['boxes'])
        print("Rows:", rows)
        print("Columns:", columns)
        self.plot_results(image, results['scores'], results['labels'], results['boxes'], rows, columns)
        for i, (row, column) in enumerate(zip(rows, columns)):
            print(f"Box {i + 1}: Row - {row}, Column - {column}")


file_path = '/Users/yanakravets/HealthFlow/Backend/file_parsing/womananalysis.pdf'
pdf_processor = TableDetection(file_path)
cropped_images = pdf_processor.process_pdf()

for image in cropped_images:
    temp_image_path = "/Users/yanakravets/HealthFlow/Backend/file_parsing/temp_image.png"
    image.save(temp_image_path)
    table_recognition = TableRecognition(temp_image_path)
    table_recognition.recognize_table_structure()
    os.remove(temp_image_path)
