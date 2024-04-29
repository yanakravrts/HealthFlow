import pandas as pd
import re
import numpy as np
import tensorflow as tf 
from tensorflow import keras

from keras_preprocessing.sequence import pad_sequences
from keras_preprocessing.text import Tokenizer
from sklearn.model_selection import train_test_split
from sklearn import tree
from sklearn.metrics import f1_score, precision_score, recall_score, confusion_matrix
import plotly.figure_factory as ff

def load_df(path: str):
    df = pd.read_csv(path)

    return df


def tokenize(text: str):
    DASH = "DASH"
    NUMBER = "NUMBER"

    text = text.lower()
    text = text.replace("-", f" {DASH} ")
    punctuation_pattern = r'[^\w\s]'
    text = re.sub(punctuation_pattern, ' ', text)
    text = re.sub(r'\d+', f" {NUMBER} ", text)
    final_tokens = []

    for token in text.split():
        token = token.strip()
        if token in [DASH, NUMBER]:
            final_tokens.append(token)
        else:
            final_tokens.extend(list(token))

    return " ".join(final_tokens)


def generate_dataset(df: pd.DataFrame):
    columns = ['Назва', 'Значення норми', 'Результат']
    name_column = "Назва" # 0
    norm_column = "Значення норми" # 1
    res_column = "Результат" # 2

    texts = []
    labels = []

    names = df[name_column]
    for name in names:
        tokens = tokenize(name)
        texts.append(tokens)
        labels.append(0)

    norms = df[norm_column]
    for norm in norms:
        tokens = tokenize(norm)
        texts.append(tokens)
        labels.append(1)

    results = df[res_column]
    for res in results:
        tokens = tokenize(res)
        texts.append(tokens)
        labels.append(2)

    df = pd.DataFrame({"x": texts, "y": labels})
    df.to_csv("updated.csv", index=False)


if __name__ == '__main__':
    data = load_df("Backend/file_parsing/updated.csv")
    texts = data["x"]
    labels = data["y"]
    max_features = 1000
    maxlen = 200

    tokenizer = Tokenizer(num_words=max_features, split=' ')
    tokenizer.fit_on_texts(texts)
    sequences = tokenizer.texts_to_sequences(texts)
    X = pad_sequences(sequences, maxlen=maxlen)
    y = np.array(labels)

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    clf = tree.DecisionTreeClassifier()
    clf = clf.fit(X_train,y_train)
    y_pred = clf.predict(X_test)

    #accuracy
    accuracy = clf.score(X_test, y_test)
    print("Accuracy:", accuracy)

    #F1 score
    f1 = f1_score(y_test, y_pred, average='weighted')
    print("F1 Score:", f1)

    #Precision
    precision = precision_score(y_test, y_pred, average=None)
    print("Precision for class:", precision)

    #Recall
    recall = recall_score(y_test, y_pred, average=None)
    print("Recall for class:", recall)

    #Confusion matrix
    confusion = confusion_matrix(y_test,y_pred, normalize='all')
    print("Confusion matrix:",confusion)
    num_classes = len(np.unique(y_test))
    fig = ff.create_annotated_heatmap(
        z=confusion,
        x=['Predicted Class ' + str(i) for i in range(num_classes)],
        y=['True Class ' + str(i) for i in range(num_classes)],
        colorscale='RdPu',
        showscale=True
    )

    fig.update_layout(
        title='Confusion Matrix',
        xaxis=dict(title='Predicted Label'),
        yaxis=dict(title='True Label')
    )

    fig.show()

    FP = confusion.sum(axis=0) - np.diag(confusion)
    FN = confusion.sum(axis=1) - np.diag(confusion)
    TP = np.diag(confusion)
    TN = confusion.sum() - (FP + FN + TP)

    #False positive
    FPR = FP / (FP + TN)
    print("False Positive rate :",FPR)

    #False negative
    FNR = FN/(TP+FN)
    print("False negative rate:",FNR)


