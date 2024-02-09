from dotenv import load_dotenv
import os
from supabase import create_client
import io
import pdfplumber
from fastapi import FastAPI, Request, Response

app = FastAPI()

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.post("/upload/")
async def upload_file(request: Request):
    form_data = await request.form()
    
    if 'file' not in form_data:
        return {"message": "No file found in form data"}
    
    file = form_data['file']
    contents = await file.read()
    
    # Завантажити файл у сховище Supabase
    response = supabase.storage.from_("file").upload(file.filename, contents)
    
    if response.status_code != 200:
        return {"message": "Error uploading file to Supabase"}
    
    return {"message": "File uploaded successfully"}

@app.get("/get_file/{file_name}")
async def get_file(file_name: str):
    # Отримати файл у байтах зі сховища Supabase
    response = supabase.storage.from_("file").download(file_name)
    
    if response.status_code != 200:
        return {"message": "Error downloading file from Supabase"}
    
    file_content = response.content
    
    # Дістати текст з PDF-файлу
    text = await extract_text_from_pdf(file_content)
    
    return {"text": text}

async def extract_text_from_pdf(file_content: bytes) -> str:
    with pdfplumber.open(io.BytesIO(file_content)) as pdf:
        text = ""
        for page in pdf.pages:
            text += page.extract_text()
    return text
