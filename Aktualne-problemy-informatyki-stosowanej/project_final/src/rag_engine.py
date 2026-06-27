import google.generativeai as genai
from src.config import GEMINI_API_KEY, MODEL_NAME

genai.configure(api_key=GEMINI_API_KEY)


class RAGEngine:
    def __init__(self):
        self.model = genai.GenerativeModel(MODEL_NAME)

    def generate_plant_knowledge(self, plant_name):
        prompt = f"""
Create a structured care guide for a houseplant called: {plant_name}

Include:
- watering
- sunlight
- humidity
- temperature
- fertilizing
- repotting
- common problems

Return concise but detailed text.
"""
        response = self.model.generate_content(prompt)
        return response.text

    def answer_question(self, question, context):
        prompt = f"""
You are a plant care expert.

Use the provided plant context to answer.

Plant context:
{context}

User question:
{question}
"""
        response = self.model.generate_content(prompt)
        return response.text