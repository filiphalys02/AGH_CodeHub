import numpy as np
import os
import faiss
import fitz
from sentence_transformers import SentenceTransformer
from google import genai
import pickle

# Klucz API do Gemini
GEMINI_API_KEY = ""

client = genai.Client(api_key=GEMINI_API_KEY)

EMBED_MODEL_NAME = "all-MiniLM-L6-v2"

# Klasa Rag
class RAG:
    # Konstruktor
    def __init__(self, pdf_path):
        self.pdf_path = pdf_path
        self.embedder = SentenceTransformer(EMBED_MODEL_NAME)
        self.index = None
        self.chunks = []

    # Wczytanie pdf - otwieram pdf, iteruje strona po stronie, zapisuje do zmiennej text
    def load_pdf(self):
        doc = fitz.open(self.pdf_path)
        text = ""
        for page in doc:
            text += page.get_text()
        return text

    # Chunkowanie tekstu - dalem dlugosc chunku 500 i overlap 100, zeby kontekst byl w miare zachowany
    def split_text(self, text, chunk_size=500, overlap=100):
        chunks = []
        start = 0
        while start < len(text):
            end = start + chunk_size
            chunks.append(text[start:end])
            start += chunk_size - overlap
        return chunks

    # Embeddingi - zaminiam chunky na wektory liczb + konwersja do float32, bo FAISS mi krzyczal blad
    def embed_texts(self, texts):
        embeddings = self.embedder.encode(texts)
        return np.array(embeddings).astype("float32")

    # Budowa indeksu FAISS
    def build_index(self, embeddings):
        dim = embeddings.shape[1] # liczba wymiarów embeddingu
        self.index = faiss.IndexFlatL2(dim)
        self.index.add(embeddings)

    # Zapytanie, czyli retrieval
    def retrieve(self, query, k=3):
        query_vec = self.embedder.encode([query]).astype("float32")
        distances, indices = self.index.search(query_vec, k)
        results = [self.chunks[i] for i in indices[0]]
        return results
    
    # na 4.5
    def load_index(self):
        self.index = faiss.read_index("faiss.index")
        with open("chunks.pkl", "rb") as f:
            self.chunks = pickle.load(f)

    # 6. Generowanie odpowiedzi (Gemini)
    def generate_answer(self, query, context_chunks):
        context = "\n\n".join(context_chunks)
        prompt = f"""
Answer the question based on the following context. If the answer is not contained within the context, say you don't know.

CONTEXT:
{context}

QUESTION:
{query}

ANSWER:
"""

        response = client.models.generate_content(
            model="models/gemini-2.5-flash",
            contents=prompt
        )

        return response.text

    # Pipeline RAG
    def build(self):
        print("Laduje PDF...")
        text = self.load_pdf()

        print("Chunkowanie...")
        self.chunks = self.split_text(text)

        print("Embedding...")
        embeddings = self.embed_texts(self.chunks)

        print("Buduje indeksy...")
        self.build_index(embeddings)

        print("Done")

    def query(self, question):
        retrieved = self.retrieve(question)
        answer = self.generate_answer(question, retrieved)
        return answer

# Wywolanie
if __name__ == "__main__":
    rag = RAG("Dudek_Petlicki_2023_Unlocking archival maps of the Hornsund fjord area for.pdf") 

    if os.path.exists("faiss.index") and os.path.exists("chunks.pkl"):
        rag.load_index()
    else:
        rag.build()

    while True:
        q = input("\nZadaj pytanie: ")
        if q.lower() in ["exit", "quit"]:
            break

        answer = rag.query(q)
        print("\nODPOWIEDŹ:\n", answer)