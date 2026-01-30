import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

SIATKA = 40   # rozmiar przestrzeni (kwadrat)
N = 3         # liczba cząstek
DYFUZJA = 0.8 # współczynnik dyfuzji
CZAS = 1000   # liczba iteracji


# Deklaracja przestrzeni
space = np.ones((SIATKA, SIATKA))

# Pozycje początkowe cząstek
czastki = {}
for k in range(N):
    czastki[k] = np.array([
        np.random.uniform(0, SIATKA),
        np.random.uniform(0, SIATKA)
    ], dtype=float)

# Figura do animacji
fig, ax = plt.subplots()
im = ax.imshow(space, cmap="viridis", vmin=0, vmax=1, origin="lower")

def update(frame):
    global space

    # Czyszczenie przestrzeni -  do wizualizacji
    space[:] = 1

    # Ruch cząstek - iteracyjny po każdej cząstce
    for n in range(N):
        x, y = czastki[n] # pobierz aktualną pozycję cząstki

        dx = np.random.normal(0, DYFUZJA) # losowy ruch w osi x
        dy = np.random.normal(0, DYFUZJA) # losowy ruch w osi y

        nx = x + dx # nowa pozycja x
        ny = y + dy # nowa pozycja y

        # granice
        if 0 <= nx < SIATKA and 0 <= ny < SIATKA:
            czastki[n] = [nx, ny]

        # narysuj cząstkę
        x, y = czastki[n]
        ix = int(x)
        iy = int(y)
        space[ix, iy] = 0

    im.set_data(space)
    return im,

ani = FuncAnimation(fig, update, frames=CZAS, interval=50, repeat=False)
plt.show()
