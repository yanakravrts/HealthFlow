import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn import tree
from sklearn.tree import export_text
from sklearn.feature_extraction.text import CountVectorizer
import re
#import matplotlib.pyplot as plt
import numpy as np

def custom_tokenizer(text):

    number_range_pattern = r'\d+\s*-\s*\d+'
    unit_pattern = r'\b\w+/\w+\b'
    word_number_pattern = r'\b\w+\b|\d+'
    tokens = re.findall(number_range_pattern + '|' + unit_pattern + '|' + word_number_pattern, text)
    return tokens


analysis_data = pd.read_csv('/Users/yanakravets/HealthFlow/Backend/file_parsing/dataset.csv')

label_encoder = LabelEncoder()
vectorizer_name = CountVectorizer(tokenizer=custom_tokenizer)
X_name = vectorizer_name.fit_transform(analysis_data['Назва'])

vectorizer_value = CountVectorizer(tokenizer=custom_tokenizer)
X_value = vectorizer_value.fit_transform(analysis_data['Значення норми'])

analysis_data = analysis_data.dropna()

X = pd.concat([pd.DataFrame(X_name.toarray()), pd.DataFrame(X_value.toarray())], axis=1)
y = analysis_data['Результат']
print(y)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

clf = tree.DecisionTreeClassifier()
clf = clf.fit(X_train,y_train)

accuracy = clf.score(X_test, y_test)
print("Accuracy:", accuracy)


y_prob = clf.predict_proba(X_test)


print("Predicted probabilities for the first five examples:")
print(y_prob[:5])

"""# Побудова текстового представлення дерева рішень
tree_rules = export_text(clf, feature_names=list(X.columns))
print(tree_rules)

# Побудова графіку рішень за допомогою Matplotlib
fig, ax = plt.subplots(figsize=(12, 12))
tree.plot_tree(clf, ax=ax, feature_names=X.columns, class_names=np.unique(y).astype('str'), filled=True)
plt.show()"""

