from fastapi import FastAPI, UploadFile, File
from fastapi.responses import RedirectResponse
from fastapi.middleware.cors import CORSMiddleware
from typing import List, Union
from langserve.pydantic_v1 import BaseModel, Field
from langchain_core.messages import HumanMessage, AIMessage, SystemMessage
from langserve import add_routes
from chain import chain
from chat import chain as chat_chain
from translator import chain as EN_TO_KO_chain
from llm import llm as model
from xionic import chain as xionic_chain
from transformers import pipeline
from collections import Counter
import re

app = FastAPI()

# LLM 모델 로드
summarizer = pipeline("summarization", model="xionic-ko-llama-3-70b")  # 예시 모델
keyword_extractor = pipeline("ner", model="xionic-ko-llama-3-70b")  # 예시 모델

@app.post("/process-document/")
async def process_document(file: UploadFile = File(...)):
    content = await file.read()
    text = content.decode("utf-8")

    # 1. 내용 요약
    summary = summarizer(text, max_length=130, min_length=30, do_sample=False)[0]['summary_text']

    # 2. 요약된 내용에서 키워드 추출
    keywords = keyword_extractor(summary)
    keyword_list = [k['word'] for k in keywords]

    # 3. 가장 많이 나온 단어 추출
    most_common_keyword = Counter(keyword_list).most_common(1)[0][0] if keyword_list else "No keyword found"

    return {"summary": summary, "keywords": keyword_list, "most_common_keyword": most_common_keyword}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
