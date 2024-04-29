import numpy as np
from PIL import Image
from detection_of_table import TableDetection
from transformers import TableTransformerForObjectDetection, DetrFeatureExtractor
import matplotlib.pyplot as plt

class TableRecognition:
    def __init__(self, image_path):
        self.image_path = image_path
        self.feature_extractor = DetrFeatureExtractor.from_pretrained("facebook/detr-resnet-50")
        self.model = TableTransformerForObjectDetection.from_pretrained("microsoft/table-transformer-structure-recognition")
        self.COLORS = [[0.000, 0.447, 0.741], [0.850, 0.325, 0.098], [0.929, 0.694, 0.125],
                       [0.494, 0.184, 0.556], [0.466, 0.674, 0.188], [0.301, 0.745, 0.933]]

    def plot_results(self, pil_img, scores, labels, boxes, rows=None, columns=None):
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
        rows = []
        columns = []
        for box in boxes:
            xmin, ymin, xmax, ymax = box
            rows.append((ymin, ymax))
            columns.append((xmin, xmax))
        rows = [(box[1].detach().numpy(), box[3].detach().numpy()) for box in boxes]
        columns = [(box[0].detach().numpy(), box[2].detach().numpy()) for box in boxes]
        return rows, columns

    def recognize_table_structure(self):
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


pdf_processor = TableDetection('Backend/file_parsing/photo_2024-04-26 23.42.33.jpeg')

cropped_images = pdf_processor.process_pdf()

for cropped_image_path in cropped_images:
    table_recognition = TableRecognition(cropped_image_path)
    table_recognition.recognize_table_structure()
