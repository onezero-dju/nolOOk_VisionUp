import streamlit as st
from transformers import pipeline, AutoTokenizer, AutoModelForSeq2SeqLM

# Streamlit 페이지 설정
st.set_page_config(page_title="Markdown 파일 요약", page_icon="📄")
st.title("Markdown 파일 요약")

# 모델 및 토크나이저 초기화
tokenizer = AutoTokenizer.from_pretrained("facebook/bart-large-cnn")
model = AutoModelForSeq2SeqLM.from_pretrained("facebook/bart-large-cnn")
summarizer = pipeline("summarization", model=model, tokenizer=tokenizer)

# 파일 업로드
uploaded_file = st.file_uploader("Markdown 파일 업로드", type=["md"])
if uploaded_file:
    content = uploaded_file.getvalue().decode("utf-8")

    # 요약 실행
    summary_results = summarizer(content, max_length=150, min_length=50, do_sample=False)
    summary_text = summary_results[0]['summary_text'] if summary_results else "요약할 수 없습니다."

    st.subheader("요약된 내용:")
    st.write(summary_text)