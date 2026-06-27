from agent import create_agent

def run():
    agent = create_agent()
    topic = input("Provide topic: ")
    query = f"""
    Find recent news about {topic}.
    
    Steps:
    - search news
    - read articles
    - summarize
    - assess importance
    - save PDF
    
    Return final summary.
    """

    result = agent.invoke(query)
    print("\nRESULT: \n")
    print(result)

if __name__ == "__main__":
    run()