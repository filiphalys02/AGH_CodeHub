import numpy as np
import matplotlib.pyplot as plt


sciezka = r"c:/aaasemestr9/Przetwarzanie równoległe/project_c++/project_c++/"

woda = np.loadtxt(sciezka + "woda.csv", delimiter=",")
zagrozenie = np.loadtxt(sciezka + "zagrozenie.csv", delimiter=",")

plt.figure(figsize=(6, 5))
plt.title("Mapa ilosci wody")
plt.imshow(woda, cmap="Blues")
plt.colorbar(label="Ilosc wody")
plt.xlabel("Kolumna")
plt.ylabel("Wiersz")
plt.show()

plt.figure(figsize=(6, 5))
plt.title("Mapa zagrozenia powodziowego")
plt.imshow(zagrozenie, cmap="Reds")
plt.colorbar(label="Zagrozenie (0-1)")
plt.xlabel("Kolumna")
plt.ylabel("Wiersz")
plt.show()
