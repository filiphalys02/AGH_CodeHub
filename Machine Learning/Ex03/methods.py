import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.datasets import load_wine

# Wczytanie danych
@st.cache_data
def load_wine_data():
    wine = load_wine()
    df = pd.DataFrame(data=wine.data, columns=wine.feature_names)
    df['target'] = wine.target
    df['class'] = df['target'].map({i: name for i, name in enumerate(wine.target_names)})
    return df

# Tabelka z 15 wierszami
def show_random_rows(data, n=15):
    st.subheader(f"Losowe {n} wierszy z danych")
    st.write(data.sample(n=n, random_state=42).reset_index(drop=True))

# Tabelka ze statystykami
def show_basic_stats(data):
    st.subheader("Podstawowe statystyki opisowe")
    st.write(data.describe())

# Macierz korelacji 
def show_correlation_matrix(data):
    st.subheader("Macierz korelacji między zmiennymi")
    corr = data.drop(columns=['target', 'class']).corr()
    fig, ax = plt.subplots(figsize=(12, 10))
    sns.heatmap(corr, annot=True, fmt=".2f", cmap="coolwarm", square=True, cbar=True, ax=ax)
    ax.set_title("Macierz korelacji cech chemicznych", fontsize=14)
    st.pyplot(fig)

# Histogram/Boxplot
def show_distribution_plots(data):
    st.subheader("Wybierz zmienną i typ wykresu")
    selected_column = st.selectbox("Wybierz zmienną", data.columns[:-2])
    plot_type = st.radio("Wybierz typ wykresu:", ("Histogram", "Boxplot"))

    fig, ax = plt.subplots(figsize=(8, 6))
    if plot_type == "Histogram":
        sns.histplot(data=data, x=selected_column, hue='class', kde=True, ax=ax)
        ax.set_title(f"Dystrybucja zmiennej: {selected_column} (Histogram)")
    else:
        sns.boxplot(data=data, x='class', y=selected_column, ax=ax)
        ax.set_title(f"Dystrybucja zmiennej: {selected_column} (Boxplot)")

    st.pyplot(fig)