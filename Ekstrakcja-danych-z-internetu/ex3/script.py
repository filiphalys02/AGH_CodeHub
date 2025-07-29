from bs4 import BeautifulSoup
import re


with open("ex3/porcja1.html", encoding="utf-8") as file:
    full_text = BeautifulSoup(file, "html.parser")
# print(type(full_text))

trs = full_text.find_all("tr")
data_rows = []
# print(type(trs))

for tr in trs:
    tds = tr.find_all("td", class_="scrutiny")
    if tds:
        values = []
        for td in tds:
            content = td.get_text(strip=True)
            if content == "None":
                values.append(None)
            elif re.match(r"^\d+(\.\d+)?$", content):
                values.append(float(content))
            elif td.find("span"): 
                values.append("emotikona")
            else:
                values.append(content)
        data_rows.append(values)
# print(data_rows)

n = len(data_rows)
m = len(data_rows[0])
# print(n, m)

##################################################### EX 1
ex1 = [data_rows[i][i] for i in range(n)]
# print(ex1)

##################################################### EX 2
ex2 = []
for offset in range(1, n):
    # nad
    przek = [data_rows[i][i + offset] for i in range(n - offset)]
    if any(not isinstance(val, float) and val is not None for val in przek):
        ex2.append((przek))
    # pod
    przek = [data_rows[i + offset][i] for i in range(n - offset)]
    if any(not isinstance(val, float) and val is not None for val in przek):
        ex2.append((przek))
# print(ex2)

##################################################### EX 3
ex3 = []
for suma in range(1, m + n - 1):
    przek = []
    for i in range(m):
        j = suma - i
        if 0 <= j < n:
            val = data_rows[i][j]
            przek.append(val)

    if any(val == "emotikona" for val in przek):
        start_col = suma if suma < n else n - 1
        ex3.append((przek))
# print(ex3)