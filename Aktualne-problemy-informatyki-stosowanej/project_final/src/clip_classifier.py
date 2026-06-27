from transformers import CLIPProcessor, CLIPModel
from PIL import Image
import torch

PLANTS = [
    "monstera plant",
    "snake plant",
    "aloe vera",
    "peace lily",
    "ficus elastica",
    "dracaena",
    "pothos",
    "zz plant"
]

class PlantClassifier:
    def __init__(self):
        self.model = CLIPModel.from_pretrained("openai/clip-vit-base-patch32")
        self.processor = CLIPProcessor.from_pretrained("openai/clip-vit-base-patch32")

    def predict(self, image_path):
        image = Image.open(image_path).convert("RGB")
        prompts = [f"photo of a {p}" for p in PLANTS]

        inputs = self.processor(text=prompts, images=image, return_tensors="pt", padding=True)
        outputs = self.model(**inputs)
        logits = outputs.logits_per_image
        probs = logits.softmax(dim=1)

        idx = torch.argmax(probs).item()
        return PLANTS[idx], float(probs[0][idx])