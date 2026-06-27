from diffusers import StableDiffusionPipeline
import torch
import os

MODEL = "runwayml/stable-diffusion-v1-5"
OUTPUT_DIR = "outputs/generated_before"

os.makedirs(OUTPUT_DIR, exist_ok=True)

pipe = StableDiffusionPipeline.from_pretrained(
    MODEL,
    torch_dtype=torch.float32
).to("cpu")

pipe.safety_checker = None

prompts = [
    "photo of a beagle dog",
    "photo of a border collie dog",
    "photo of a chihuahua dog",
    "photo of a golden retriever dog",
    "photo of a dingo dog"
]

with torch.no_grad():
    for i, prompt in enumerate(prompts):
        image = pipe(prompt, num_inference_steps=20).images[0]
        image.save(f"{OUTPUT_DIR}/{i}.png")