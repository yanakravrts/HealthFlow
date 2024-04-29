import pandas as pd
import re
import numpy as np
import tensorflow as tf 
from tensorflow import keras

from keras import Sequential
from keras.layers import LSTM, Dense, Embedding, SpatialDropout1D
from keras_preprocessing.sequence import pad_sequences
from keras_preprocessing.text import Tokenizer
from sklearn.model_selection import train_test_split


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

    model = Sequential()
    model.add(Embedding(max_features, 128))
    model.add(SpatialDropout1D(0.2))
    model.add(LSTM(128, dropout=0.2, recurrent_dropout=0.2))
    model.add(Dense(1, activation='sigmoid'))

    model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

    # Training
    batch_size = 32
    epochs = 10
    model.fit(X_train, y_train, batch_size=batch_size, epochs=epochs, validation_data=(X_test, y_test))

    # Evaluation
    loss, accuracy = model.evaluate(X_test, y_test)
    print(f'Test Loss: {loss}')
    print(f'Test Accuracy: {accuracy}')