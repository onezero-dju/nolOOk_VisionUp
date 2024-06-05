# 요약->키워드->빈번한 키워드 도출 코드 (2): 모델 바꾸고 요약 성능 UP - Fail

import streamlit as st
from fastapi import FastAPI, UploadFile, File
from transformers import pipeline, AutoTokenizer, AutoModelForSeq2SeqLM
from collections import Counter
import os
import re

app = FastAPI()

# 필요한 디렉토리 생성
os.makedirs(".cache/files", exist_ok=True)

# 요약 모델 초기화
tokenizer = AutoTokenizer.from_pretrained("facebook/bart-large-cnn")
model = AutoModelForSeq2SeqLM.from_pretrained("facebook/bart-large-cnn")
summarizer = pipeline("text-generation", model=model, tokenizer=tokenizer)

@app.post("/upload-markdown/")
async def upload_markdown(file: UploadFile = File(...)):
    content = await file.read()
    text = content.decode("utf-8")
    # 파일 저장
    file_path = f"./.cache/files/{file.filename}"
    with open(file_path, "w") as f:
        f.write(text)
    # 파일 내용 요약
    summary = summarizer(text, max_length=1024, min_length=100, do_sample=False)[0]['summary_text']
    return {"filename": file.filename, "summary": summary, "message": "File uploaded and summarized successfully"}

st.set_page_config(page_title="Markdown 파일 요약 및 키워드 추출", page_icon="📄")
st.title("Markdown 파일 요약 및 키워드 추출")

# 키워드 추출 함수
def extract_keywords(text, num_keywords=5):
    words = re.findall(r'\b\w+\b', text.lower())
    count = Counter(words)
    keywords = count.most_common(num_keywords)
    return [word for word, freq in keywords]

uploaded_file = st.file_uploader("Markdown 파일 업로드", type=["md"])
if uploaded_file:
    content = uploaded_file.getvalue().decode("utf-8")
    
    # 파일 내용 기반으로 간단하게 요약해줘
    prompt_text = f"파일 내용 기반으로 간단하게 요약해줘:\n{content}"
    summary_results = summarizer(prompt_text, max_length=150, num_return_sequences=1)
    summary_text = summary_results[0]['generated_text']

    st.subheader("요약된 내용:")
    st.write(summary_text)

    # 키워드 추출
    keywords = extract_keywords(summary_text)
    st.subheader("추출된 키워드:")
    st.write([word for word, _ in keywords])
    st.subheader("가장 많이 나온 키워드:")
    st.write(keywords[0][0] if keywords else "No keywords found")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)