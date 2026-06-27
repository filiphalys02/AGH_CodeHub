import os
import json

root = "C:\\aaasemestr10\\APIS_AI\\project4\\data\\combined"
output_file = os.path.join(root, "metadata.jsonl")

files = os.listdir(root)

with open(output_file, "w") as f:
    for file in files:
        if file.endswith(".jpg") or file.endswith(".png"):
            
            if "beagle" in file:
                breed = "beagle"
            elif "border collie" in file or "border_collie" in file:
                breed = "border collie"
            elif "chihuahua" in file:
                breed = "chihuahua"
            elif "golden" in file:
                breed = "golden retriever"
            elif "dingo" in file:
                breed = "dingo"
            else:
                continue

            caption = f"photo of {breed} dog"

            f.write(json.dumps({
                "file_name": file,
                "text": caption
            }) + "\n")

print("Metadata created!")