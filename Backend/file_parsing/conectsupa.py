import os
import pickle
from dotenv import load_dotenv
from supabase import create_client

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)
file_name = "classification_model.pkl" 
response = supabase.storage.from_("classifier").download(file_name)
clf = pickle.loads(response)


