from src.clip_classifier import PlantClassifier
from src.vector_store import VectorStore
from src.rag_engine import RAGEngine


class PlantAgent:
    def __init__(self):
        self.classifier = PlantClassifier()
        self.store = VectorStore()
        self.rag = RAGEngine()
        self.current_plant = None

    def analyze_image(self, image_path):
        plant, confidence = self.classifier.predict(image_path)
        self.current_plant = plant

        plant_knowledge = self.rag.generate_plant_knowledge(plant)

        self.store = VectorStore()
        self.store.add_documents([plant_knowledge])

        return plant, confidence

    def chat(self, user_message):
        context_docs = self.store.search(user_message)
        context = "\n".join(context_docs)
        return self.rag.answer_question(user_message, context)