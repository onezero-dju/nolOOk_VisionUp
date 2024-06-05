import streamlit as st
from fastapi import FastAPI, UploadFile, File
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
from collections import Counter
import os
import re

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
    # 비문자 제거 및 소문자로 변환
    words = re.findall(r'\b\w+\b', text.lower())
    count = Counter(words)
    keywords = count.most_common(num_keywords)
    return keywords

st.set_page_config(page_title="Markdown 파일 키워드 추출", page_icon="📄")
st.title("Markdown 파일 키워드 추출")

uploaded_file = st.file_uploader("Markdown 파일 업로드", type=["md"])
if uploaded_file:
    content = uploaded_file.getvalue().decode("utf-8")
    keywords = extract_keywords(content)
    st.subheader("추출된 키워드:")
    st.write([word for word, _ in keywords])
    st.subheader("가장 많이 나온 키워드:")
    st.write(keywords[0][0] if keywords else "No keywords found")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)