from dotenv import load_dotenv
import os
from supabase import create_client
import io
import pdfplumber
from logger_file import logger
from error import Error
from fastapi import FastAPI, Request, Response

app = FastAPI()
error = Error()

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.post("/upload/")
async def upload_file(request: Request):
    try:
        form_data = await request.form()
        
        if 'file' not in form_data:
            return error.error_404("No file found in form data")
        
        file = form_data['file']
        contents = await file.read()

        response = supabase.storage.from_("file").upload(file.filename, contents)
        
        if response.status_code != 200:
            return error.error_404(f"Error uploading file to Supabase: {response.text}")
        
        logger.info("File uploaded successfully")
        return {"message": "File uploaded successfully"}
    except Exception as e:
        return error.error_500(e, "An error occurred while uploading file")

@app.get("/get_file/{file_name}")
async def get_file(file_name: str):
    try:
        response = supabase.storage.from_("file").download(file_name)
        
        if len(response) == 0:
            return error.error_404(f"Error downloading file from Supabase")  
        file_content = response
        text = await extract_text_from_pdf(file_content)
        if not text:
            return error.error_404(f"PDF file does not contain any text")
        logger.info("Extracted text from PDF")
        print(text)
        return {"text": text}
    except Exception as e:
        return error.error_500(e, "An error occurred while downloading file")


async def extract_text_from_pdf(file_content: bytes) -> str:
    with pdfplumber.open(io.BytesIO(file_content)) as pdf:
        text = ""
        for page in pdf.pages:
            text += page.extract_text(layout = True)
    return text

