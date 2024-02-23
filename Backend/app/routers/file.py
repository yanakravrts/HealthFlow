from dotenv import load_dotenv
import os
from supabase import create_client
from Backend.other.logger_file import logger
from Backend.other.error import Error
from fastapi import Request, APIRouter
from Backend.managers.file_manager import extract_text_from_pdf

router = APIRouter()
error = Error()

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)


@router.post("/upload/", tags=["file"])
async def upload_file(request: Request):
    """
    Handles the upload of a file to Supabase storage.

    Arguments:
    - request: A FastAPI Request object representing the incoming request.

    Returns:
    - dictionary with the message "File uploaded successfully".
    """
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


@router.get("/get_file/{file_name}", tags=["file"])
async def get_file(file_name: str):
    """
    Retrieves a file from Supabase storage and extracts text from a PDF file if available.

    Arguments:
    - file_name: A string representing the name of the file to retrieve.

    Returns:
    - dictionary with the extracted text from the PDF file.
    """
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

