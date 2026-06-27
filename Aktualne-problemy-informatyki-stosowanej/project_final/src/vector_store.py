from sentence_transformers import SentenceTransformer
import faiss
import numpy as np


class VectorStore:
    def __init__(self):
        self.embedder = SentenceTransformer("all-MiniLM-L6-v2")
        self.dimension = 384
        self.index = faiss.IndexFlatL2(self.dimension)
        self.documents = []

    def add_documents(self, docs):
        if not docs:
            return

        if isinstance(docs, str):
            docs = [docs]

        embeddings = self.embedder.encode(docs)

        embeddings = np.array(embeddings).astype("float32")

        if embeddings.ndim == 1:
            embeddings = embeddings.reshape(1, -1)

        self.index.add(embeddings)
        self.documents.extend(docs)

    def search(self, query, k=3):
        if len(self.documents) == 0:
            return []

        q_emb = self.embedder.encode([query])
        q_emb = np.array(q_emb).astype("float32")

        distances, ids = self.index.search(q_emb, min(k, len(self.documents)))

        results = []
        for idx in ids[0]:
            if 0 <= idx < len(self.documents):
                results.append(self.documents[idx])

        return results