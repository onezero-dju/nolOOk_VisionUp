from fastapi import FastAPI, UploadFile, File
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
from collections import Counter
import os

app = FastAPI()

# 필요한 디렉토리 생성
os.makedirs(".cache/files", exist_ok=True)

@app.post("/upload-markdown/")
async def upload_markdown(file: UploadFile = File(...)):
    content = await file.read()
    text = content.decode("utf-8")
    # 파일 저장
    file_path = f"./.cache/files/{file.filename}"
    with open(file_path, "w") as f:
        f.write(text)
    return {"filename": file.filename, "message": "File uploaded successfully"}

# 키워드 추출 함수
def extract_keywords(text, num_keywords=5):
    words = text.split()
    count = Counter(words)
    keywords = count.most_common(num_keywords)
    return [word for word, freq in keywords]

# Streamlit 프론트엔드
import streamlit as st

st.set_page_config(page_title="Markdown 파일 키워드 추출", page_icon="📄")
st.title("Markdown 파일 키워드 추출")

uploaded_file = st.file_uploader("Markdown 파일 업로드", type=["md"])
if uploaded_file:
    content = uploaded_file.getvalue().decode("utf-8")
    keywords = extract_keywords(content)
    st.write("추출된 키워드:")
    st.write(keywords)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)