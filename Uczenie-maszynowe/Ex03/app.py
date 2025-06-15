import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.datasets import load_wine
from methods import *

# Główna funkcja aplikacji
def main():
    st.set_page_config(page_title="Wine EDA", page_icon="🍷", initial_sidebar_state="collapsed")

    st.title("Eksploracyjna Analiza Danych (EDA) – Zbiór Wine")

    # Wczytanie danych
    wine_data = load_wine_data()

    # Pokaż randomowe 15 rekordów
    show_random_rows(wine_data)

    # Tabelka ze statystykami
    show_basic_stats(wine_data)

    # Histogram/Boxplot
    show_distribution_plots(wine_data)

    # Macierz korelacji
    show_correlation_matrix(wine_data)

# Uruchomienie
if __name__ == "__main__":
    main()
