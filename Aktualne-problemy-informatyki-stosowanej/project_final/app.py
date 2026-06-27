import streamlit as st
import tempfile
from src.agent import PlantAgent

st.set_page_config(page_title="Plant AI Assistant", layout="wide")

if "agent" not in st.session_state:
    st.session_state.agent = PlantAgent()

if "messages" not in st.session_state:
    st.session_state.messages = []

st.title("🌿 Plant AI Assistant")

with st.sidebar:
    st.header("Upload plant image")
    uploaded_file = st.file_uploader("Choose image", type=["jpg", "png", "jpeg"])

    if uploaded_file:
        with tempfile.NamedTemporaryFile(delete=False, suffix=".jpg") as tmp:
            tmp.write(uploaded_file.read())
            image_path = tmp.name

        plant, conf = st.session_state.agent.analyze_image(image_path)
        st.success(f"Detected: {plant} ({conf:.2%})")

for msg in st.session_state.messages:
    with st.chat_message(msg["role"]):
        st.write(msg["content"])

prompt = st.chat_input("Ask about your plant...")

if prompt:
    st.session_state.messages.append({"role": "user", "content": prompt})

    with st.chat_message("user"):
        st.write(prompt)

    answer = st.session_state.agent.chat(prompt)

    with st.chat_message("assistant"):
        st.write(answer)

    st.session_state.messages.append({"role": "assistant", "content": answer})