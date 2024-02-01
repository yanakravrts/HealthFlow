from dotenv import load_dotenv
load_dotenv()

import os

from supabase import create_client
from gotrue.errors import AuthError


url = os.environ.get("SUPABASE_URL")
key = os.environ.get("SUPABASE_KEY")

supabase = create_client(url, key)

users_email = "volodimirobaranik@gmail.com"
users_password = "health2023flow"

user = supabase.auth.sign_up({ "email": users_email, "password": users_password })
session = None
try:
    session = supabase.auth.sign_in_with_password({ "email": users_email, "password": users_password })
except AuthError:
    print("login failed")
print(session)


supabase.auth.sign_out()