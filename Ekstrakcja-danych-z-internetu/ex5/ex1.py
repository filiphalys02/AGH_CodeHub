from bs4 import BeautifulSoup
from urllib.request import urlopen


link = 'https://web-scraping.dev/product/13'

html = urlopen(link)

soup = BeautifulSoup(html.read(), 'html.parser')

imgs = soup.find_all("img", class_ = "product-img")


#print(imgs)

for img in imgs:
    link = img['src']

    file_name = link.split('/')[-1]

    open_link = urlopen(link)

    image = open_link.read()

    x = open(file_name, 'wb')
    x.write(image)
