#!/bin/bash

MODEL="runwayml/stable-diffusion-v1-5"
DATA_DIR="data/combined"
OUTPUT_DIR="outputs/lora"

accelerate launch diffusers/examples/text_to_image/train_text_to_image_lora.py \
  --pretrained_model_name_or_path=$MODEL \
  --train_data_dir=$DATA_DIR \
  --resolution=512 \
  --train_batch_size=1 \
  --num_train_epochs=5 \
  --learning_rate=1e-4 \
  --output_dir=$OUTPUT_DIR \
  --mixed_precision="fp16" \
  --gradient_checkpointing