from langchain_core.tools import tool
from langchain_google_genai import ChatGoogleGenerativeAI

GOOGLE_API_KEY = ""

llm = ChatGoogleGenerativeAI(
    model="gemini-2.5-flash",
    google_api_key=GOOGLE_API_KEY,
    temperature=0.3
)

@tool
def assess_importance(summary: str) -> str:
    """
    Classifies importance: low, medium, high.
    """

    prompt = f"""
    Evaluate importance based on:
    - global impact
    - economy
    - technology

    Return ONLY one word: low / medium / high

    {summary}
    """

    return llm.invoke(prompt).content.strip().lower()