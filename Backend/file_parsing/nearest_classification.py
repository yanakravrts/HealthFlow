import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.neighbors import NearestCentroid
from sklearn.feature_extraction.text import CountVectorizer
import re

def custom_tokenizer(text):

    number_range_pattern = r'\d+\s*-\s*\d+'
    unit_pattern = r'\b\w+/\w+\b'
    word_number_pattern = r'\b\w+\b|\d+'
    tokens = re.findall(number_range_pattern + '|' + unit_pattern + '|' + word_number_pattern, text)
    return tokens


analysis_data = pd.read_csv('/Users/yanakravets/HealthFlow/Backend/file_parsing/dataset.csv')

# Перетворення категоріальних міток у числовий формат
label_encoder = LabelEncoder()

vectorizer_name = CountVectorizer(tokenizer=custom_tokenizer)
X_name = vectorizer_name.fit_transform(analysis_data['Назва'])

vectorizer_value = CountVectorizer(tokenizer=custom_tokenizer)
X_value = vectorizer_value.fit_transform(analysis_data['Значення норми'])

analysis_data = analysis_data.dropna()

X = pd.concat([pd.DataFrame(X_name.toarray()), pd.DataFrame(X_value.toarray())], axis=1)
y = analysis_data['Результат']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

clf = NearestCentroid()
print(X_train)
clf.fit(X_train,y_train)
accuracy = clf.score(X_test, y_test)
print("Accuracy:", accuracy)


y_prob = clf.predict(X_test)

print("Predicted probabilities for the first five examples:")
print(y_prob[:100])
