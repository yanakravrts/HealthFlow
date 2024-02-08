from dotenv import load_dotenv
load_dotenv()
from fastapi import FastAPI, Request, HTTPException, Response
import os
from supabase import create_client

app = FastAPI()

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
    
    response = supabase.storage.from_("file").upload(file.filename, contents)
    
    if response.status_code == 200:
        return {"message": "File uploaded successfully"}
    else:
        return {"message": "Error uploading file to Supabase"}
    

@app.get("/download/{file_name}")
async def download_file(file_name: str):
    response = supabase.storage.from_("file").download(file_name)
    return Response(content=response, media_type="application/octet-stream", headers={"Content-Disposition": f"attachment; filename={file_name}"})

# @app.get("/download/{file_name}")
# async def download_file(file_name: str):
#     response = supabase.storage.from_("file").create_signed_url(file_name, expires_in=3600)
#     if response.get("error"):
#         return response, 500
#     return {"file_url": response["signedURL"]}