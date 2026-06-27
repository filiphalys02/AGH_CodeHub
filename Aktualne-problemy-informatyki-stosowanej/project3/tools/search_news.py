from langchain_core.tools import tool
import requests

NEWS_API_KEY = ""

def is_valid_article(url: str) -> bool:
    blocked = [
        "consent.yahoo.com",
        "login",
        "subscribe",
        "accounts",
    ]
    return not any(b in url for b in blocked)


@tool
def search_news(topic: str) -> list:
    url = "https://newsapi.org/v2/everything"
    params = {
        "q": topic,
        "pageSize": 5,
        "sortBy": "publishedAt",
        "apiKey": NEWS_API_KEY
    }

    response = requests.get(url, params=params).json()

    articles = []
    for a in response.get("articles", []):
        article_url = a.get("url")

        if not article_url or not is_valid_article(article_url):
            continue

        articles.append({
            "title": a.get("title"),
            "url": article_url
        })

    return articles