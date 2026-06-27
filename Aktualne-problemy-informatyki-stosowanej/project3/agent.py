from langchain.agents import initialize_agent, AgentType
from langchain_google_genai import ChatGoogleGenerativeAI

from tools.search_news import search_news
from tools.summarize import summarize_news
from tools.crawl import crawl_article
from tools.importance import assess_importance
from tools.save_pdf import save_pdf

GOOGLE_API_KEY = ""

def create_agent():

    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-flash",
        google_api_key=GOOGLE_API_KEY,
        temperature=0.3,
        convert_system_message_to_human=True
    )

    tools = [
        search_news,
        crawl_article,
        summarize_news,
        assess_importance,
        save_pdf
    ]

    system_prompt = """
    You are an autonomous AI research agent.

    Your goal is to gather recent news about a topic and produce a detailed summary.

    You can:
    - search for news
    - read full articles
    - summarize
    - evaluate importance
    - save reports

    Rules:
    - Decide yourself which tools to use
    - If data is incomplete, search again
    - Use article content, not only titles
    - Produce structured markdown summaries
    - Always aim for accuracy
    """

    agent = initialize_agent(
        tools,
        llm,
        agent=AgentType.OPENAI_FUNCTIONS,
        verbose=True,
        system_message=system_prompt
    )

    return agent


#import google.generativeai as genai
#genai.configure(api_key=GOOGLE_API_KEY)
#for m in genai.list_models():
#    print(m.name)