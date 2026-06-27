from langchain_core.tools import tool
from reportlab.platypus import SimpleDocTemplate, Paragraph
from reportlab.lib.styles import getSampleStyleSheet
from datetime import datetime

@tool
def save_pdf(markdown_text: str, topic: str, importance: str) -> str:
    date = datetime.now().strftime("%Y-%m-%d")
    filename = f"{date}_{topic}_{importance}.pdf"

    doc = SimpleDocTemplate(filename)
    styles = getSampleStyleSheet()

    story = []

    for line in markdown_text.split("\n"):
        story.append(Paragraph(line, styles["Normal"]))

    doc.build(story)

    return filename