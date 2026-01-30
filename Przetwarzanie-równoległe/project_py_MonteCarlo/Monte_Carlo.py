import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from scipy.stats import norm
from sklearn.metrics import r2_score

SIATKA = 100  # rozmiar przestrzeni (kwadrat)
N = 5         # liczba cząstek
DYFUZJA = 1.0 # współczynnik dyfuzji
CZAS = 1000   # liczba iteracji


# Deklaracja przestrzeni
space = np.ones((SIATKA, SIATKA))

# Pozycje początkowe cząstek
czastki = {}
historia = {}
for k in range(N):
    czastki[k] = np.array([SIATKA//2, SIATKA//2], dtype=float)
    historia[k] = [[np.float64(SIATKA//2)], [np.float64(SIATKA//2)]]

# Figura do animacji
fig, ax = plt.subplots()
im = ax.imshow(space, cmap="viridis", vmin=0, vmax=1, origin="lower")


def update(frame):
    global space, historia

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

        historia[n][0].append(x)
        historia[n][1].append(y)

    im.set_data(space)
    return im,

ani = FuncAnimation(fig, update, frames=CZAS-2, interval=50, repeat=False)
plt.show()

# Histogramy pozycji cząstek
fig, axes = plt.subplots(
    2, N,
    figsize=(3*N, 6),
    sharex='col'
)

# Góra X, Dół Y
for n in range(N):
    axes[0, n].hist(historia[n][0], bins=20, range=(0, SIATKA))
    axes[0, n].set_title(f"Cząstka {n+1}")
    axes[0, n].set_xlabel("x")
    axes[0, n].set_ylabel("ilość wystąpień")

    axes[1, n].hist(historia[n][1], bins=20, orientation="horizontal", range=(0, SIATKA))
    axes[1, n].set_xlabel("ilość wystąpień")
    axes[1, n].set_ylabel("y")

plt.show()


def statystyki(dane):
    # średnia
    mean = np.mean(dane)
    # wariancja
    var = np.var(dane)
    # r2
    hist, bin_edges = np.histogram(dane, bins=20, range=(0, SIATKA), density=True)
    centers = 0.5 * (bin_edges[:-1] + bin_edges[1:])
    mu, sigma = norm.fit(dane)
    gauss = norm.pdf(centers, mu, sigma)
    r2 = r2_score(hist, gauss)

    return mean, var, r2

# Statystyki dyfuzji
print("STATYSTYKI DYFUZJI\n")

for n in range(N):
    X = np.array(historia[n][0])
    Y = np.array(historia[n][1])

    mean_x, var_x, r2_x = statystyki(X)
    mean_y, var_y, r2_y = statystyki(Y)

    print(f"Cząstka {n+1}:")
    print(f"  Oś X: średnia = {mean_x:.3f}, wariancja = {var_x:.3f}, R2 = {r2_x:.3f}")
    print(f"  Oś Y: średnia = {mean_y:.3f}, wariancja = {var_y:.3f}, R2 = {r2_y:.3f}")
    print()