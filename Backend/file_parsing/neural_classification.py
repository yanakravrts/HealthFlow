import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.neural_network import MLPClassifier
from sklearn.feature_extraction.text import CountVectorizer
import re

def custom_tokenizer(text):
    # Регулярний вира число-число
    number_range_pattern = r'\d+\s*-\s*\d+'
    # для одиниць вимірювання
    unit_pattern = r'\b\w+/\w+\b'
    # для всіх слів або чисел
    word_number_pattern = r'\b\w+\b|\d+'

    
    tokens = re.findall(number_range_pattern + '|' + unit_pattern + '|' + word_number_pattern, text)
    return tokens


analysis_data = pd.read_csv('/Users/yanakravets/HealthFlow/Backend/file_parsing/dataset.csv')

# Перетворення категоріальних міток у числовий формат
label_encoder = LabelEncoder()
analysis_data['Назва'] = label_encoder.fit_transform(analysis_data['Назва'])
analysis_data['Значення норми'] = label_encoder.fit_transform(analysis_data['Значення норми'])
analysis_data = analysis_data.dropna()


X = analysis_data[['Назва', 'Значення норми']]
y = analysis_data['Результат']
print(X.shape)
print(y.shape)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)


clf = MLPClassifier(random_state=42)
clf.fit(X_train, y_train)
MLPClassifier(alpha=1e-05, hidden_layer_sizes=(5, 2), random_state=42,
              solver='lbfgs')

accuracy = clf.score(X_test, y_test)
print("Accuracy:", accuracy)

y_prob = clf.predict_proba(X_test)

print("Predicted probabilities for the first five examples:")
print(y_prob[:5])

