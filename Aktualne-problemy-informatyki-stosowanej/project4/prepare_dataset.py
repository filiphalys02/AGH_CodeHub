import os
import shutil

base_dir = "C:/aaasemestr10/APIS_AI/project4/data/processed"
combined_dir = os.path.join(base_dir, "combined")

os.makedirs(combined_dir, exist_ok=True)

breeds = [
    "border_collie",
    "golden_retriever",
    "chihuahua",
    "dingo",
    "beagle"
]

for breed in breeds:
    breed_path = os.path.join(base_dir, breed)
    
    counter = 1
    
    for filename in os.listdir(breed_path):
        if filename.lower().endswith(".jpg") and "_" in filename:
            
            src_path = os.path.join(breed_path, filename)
            
            new_name = f"{breed}_{counter}.jpg"
            dst_path = os.path.join(combined_dir, new_name)
            
            while os.path.exists(dst_path):
                counter += 1
                new_name = f"{breed}_{counter}.jpg"
                dst_path = os.path.join(combined_dir, new_name)
            
            shutil.copy2(src_path, dst_path)
            counter += 1

print("Gotowe")
