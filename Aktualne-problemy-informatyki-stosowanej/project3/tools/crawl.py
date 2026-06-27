from langchain_core.tools import tool

@tool
def crawl_article(url: str) -> str:
    return f"Content from article: {url}"