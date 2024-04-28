from typing import Annotated
from fastapi import Depends, FastAPI, HTTPException, status, Form
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from pydantic import BaseModel
from Backend.base.supa_client import supabase_client
from Backend.other.hashing_password import hash_password


app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# class User(BaseModel):
#     email: str
#     full_name: str | None = None
#     disabled: bool | None = None

# class UserInDB(User):
#     hashed_password: str

# def authenticate_user(email: str, password: str):
#     try:
#         response = supabase_client.supabase.table("password_with_mail").select("password").eq("mail", email).execute()
#         data = response.data
#         first_item = data[0]
#         password_value = first_item['password']
#         if password_value == hash_password(password):
#                 return True
#         return False
#     except Exception as e:
#         print(f"Помилка: {e}")
#         return False

# @app.post("/token1")
# def get_user(useremail: str):
#     response = supabase_client.supabase.table("password_with_mail").select("mail", "password").eq("mail", useremail).execute()
#     return(response.data)
    
# def decode_token(token):
#     # This doesn't provide any security at all
#     # Check the next version
#     user = get_user(token)
#     return user

# async def get_current_user(token: Annotated[str, Depends(oauth2_scheme)]):
#     user = decode_token(token)
#     if not user:
#         raise HTTPException(
#             status_code=status.HTTP_401_UNAUTHORIZED,
#             detail="Недійсні облікові дані для аутентифікації",
#             headers={"WWW-Authenticate": "Bearer"},
#         )
#     return user

# async def get_current_active_user(
#     current_user: Annotated[User, Depends(get_current_user)],
# ):
#     if current_user.disabled:
#         raise HTTPException(status_code=400, detail="Неактивний користувач")
#     return current_user

# @app.post("/token")
# async def login(email: str = Form(...), password: str = Form(...)):
#     if not authenticate_user(email, password):
#         raise HTTPException(status_code=400, detail="Неправильна електронна пошта або пароль")
#     return {"access_token": email, "token_type": "bearer"}

# @app.get("/users/me")
# async def read_users_me(
#     current_user: Annotated[User, Depends(get_current_active_user)],
# ):
#     return current_user

from pydantic import BaseModel

class User(BaseModel):
    mail: str
    password: str

@app.post("/token")
def get_user(useremail: str) -> User:
    response = supabase_client.supabase.table("password_with_mail").select("mail", "password").eq("mail", useremail).execute()
    user_data = response.data[0] if response.data else None
    if user_data:
        return User(**user_data)
    return None
