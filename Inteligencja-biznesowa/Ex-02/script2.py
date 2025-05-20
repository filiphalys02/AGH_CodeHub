import requests

# Endpoint API
api_url = "https://api-dbw.stat.gov.pl/api/variable/variable-data-section"

# Parametry zapytania (przykładowe)
params = {
    "id-zmienna": "305",   # ID zmiennej
    "id-przekroj": "736",  # ID przekroju
    "id-rok": "2023",      # Rok
    "id-okres": "251",     # Okres
    "ile-na-stronie": "5000",
    "numer-strony": "0",
    "lang": "pl"           # Język
}

# Nagłówki z kluczem API (tutaj musisz podać swój klucz)
headers = {
    "X-ClientId": "TWÓJ_KLUCZ_API"
}

# Wysłanie zapytania
response = requests.get(api_url, params=params, headers=headers)

# Sprawdzenie odpowiedzi
if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print(f"Błąd: {response.status_code}")
    print(response.text)
