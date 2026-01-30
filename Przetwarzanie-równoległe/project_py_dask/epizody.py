import dask.dataframe as dd
import warnings
warnings.filterwarnings("ignore")

# Dane generowane są w pliku generator.py

# Wczytanie danych
path = "c:/aaasemestr9/Przetwarzanie równoległe/project_py_dask/"
df = dd.read_csv(path + "dane_pm25.csv", parse_dates=["data"] )
df = df.set_index("data").map_partitions(lambda x: x.sort_index())



# ZADANIE 1
df["high"] = df["pm25"] > 35

df["episode_start"] = (df["high"] & (~df["high"].shift(1).fillna(False)))

df["episode_id"] = (df.groupby("Id_punktu")["episode_start"].cumsum())

episodes = df[df["high"]]

episodes = episodes.reset_index()

# Agregacja epizodów
episode_stats = (
    episodes
    .groupby(["Id_punktu", "episode_id"])
    .agg(
        liczba_pomiarow=("pm25", "size"),
        max_pm25=("pm25", "max"),
        start=("data", "min"),
        end=("data", "max")
    )
)

# Czas trwania
episode_stats["duration_min"] = ( (episode_stats["end"] - episode_stats["start"]).dt.total_seconds() / 60 )

# Statystyki końcowe
final_stats = (
    episode_stats.groupby("Id_punktu").agg
    (
        liczba_epizodow=("duration_min", "count"),
        sredni_czas_trwania_min=("duration_min", "mean"),
        maksymalne_pm25=("max_pm25", "max")
    )
)

final_stats.to_csv(path + "zadanie1.csv", single_file=True)


# ZADANIE 2
rolling_3h_max = (df[["Id_punktu", "pm25"]].groupby("Id_punktu").rolling("3H").max().reset_index())

rolling_3h_max["minute"] = rolling_3h_max["data"].dt.minute

rolling_3h_max = rolling_3h_max[rolling_3h_max["minute"] == 0]

rolling_3h_max = rolling_3h_max.drop(columns=["minute"])

rolling_3h_max.to_csv(path + "zadanie2.csv", single_file=True)


# ZADANIE 3
def daily_p95_partition(pdf):
    result = (pdf.set_index("data").groupby("Id_punktu").resample("1D")["pm25"].quantile(0.95).reset_index())

    return result[["data", "Id_punktu", "pm25"]]

df_tmp = df.reset_index()

daily_p95 = df_tmp.map_partitions(daily_p95_partition, meta = 
    {
        "data":      "datetime64[ns]",
        "Id_punktu": "int64",
        "pm25":      "float64",
    }
)

daily_p95.to_csv(path + "zadanie3.csv", single_file=True)
