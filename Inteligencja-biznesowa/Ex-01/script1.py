import requests
from bs4 import BeautifulSoup
import pandas as pd
import time

base_url = "https://books.toscrape.com/catalogue/page-{}.html"

data = []

page = 1
while True:
    try:
        url = base_url.format(page)
        response = requests.get(url)

        if response.status_code != 200:
            break

        soup = BeautifulSoup(response.text, "html.parser")
        books = soup.find_all("article", class_="product_pod")
        
        for book in books:

            try:
                title = book.h3.a["title"]
                price = book.find("p", class_="price_color").text.strip()[2:]
                availability = book.find("p", class_="instock availability").text.strip()
                data.append({"Tytuł": title, "Cena": price, "Dostępność": availability})

            except Exception as e:
                    print(f"Błąd przy przetwarzaniu książki: {e}")
        
        print(f"Pobrano stronę {page}")  
        page += 1  

        time.sleep(1)

    except requests.RequestException as e:
        print(f"Błąd przy pobieraniu strony {page}: {e}")
        break


df = pd.DataFrame(data)

df.to_csv("Ex-01/export.csv", index=False, encoding="utf-8")

print(df.head())
