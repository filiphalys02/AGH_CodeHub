from langchain_core.tools import tool
from langchain_google_genai import ChatGoogleGenerativeAI

GOOGLE_API_KEY = ""

llm = ChatGoogleGenerativeAI(
    model="gemini-2.5-flash",
    google_api_key=GOOGLE_API_KEY,
    temperature=0.3
)

@tool
def summarize_news(content: str) -> str:
    prompt = f"""
    Create a structured markdown summary based on the following content.

    Include:
    - Key events
    - Main trends
    - Important facts

    Content:
    {content}
    """

    return llm.invoke(prompt).content