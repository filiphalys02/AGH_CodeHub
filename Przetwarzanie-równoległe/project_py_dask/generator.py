import pandas as pd
import numpy as np

np.random.seed(42)

# parametry
liczba_punktow = 5
dni = 2
sredni_krok_s = 30
epizod_szansa = 0.05

rekordy = []

start = pd.Timestamp("2024-01-01 00:00:00")

for punkt in range(1, liczba_punktow + 1):
    t = start
    end = start + pd.Timedelta(days=dni)
    epizod = False
    epizod_koniec = None

    while t < end:
        # krok czasowy
        dt = np.random.randint(10, 120)
        t += pd.Timedelta(seconds=dt)

        # logika epizodu
        if not epizod and np.random.rand() < epizod_szansa:
            epizod = True
            epizod_koniec = t + pd.Timedelta(minutes=np.random.randint(5, 30))

        if epizod and t > epizod_koniec:
            epizod = False

        if epizod:
            pm25 = np.random.normal(55, 10)
        else:
            pm25 = np.random.normal(18, 5)

        rekordy.append({
            "data": t,
            "Id_punktu": punkt,
            "pm25": max(pm25, 1)
        })

df = pd.DataFrame(rekordy)

# zapis
df.to_csv("dane_pm25.csv", index=False)
print(df.head())
