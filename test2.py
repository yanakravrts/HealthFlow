from datetime import datetime, timedelta, timezone
from typing import Annotated
from jose import JWTError, jwt
from passlib.context import CryptContext
from pydantic import BaseModel
from fastapi import Depends, FastAPI, HTTPException, status, Form
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from Backend.base.supa_client import supabase_client
from Backend.other.hashing_password import hash_password
import hashlib

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# to get a string like this run:
# openssl rand -hex 32
SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    useremail: str | None = None


class User(BaseModel):
    useremail: str
    password: str


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")



def verify_password(plain_password, hashed_password):
    return hashed_password == hashlib.sha256(plain_password.encode()).hexdigest()


def get_password_hash(password):
    return pwd_context.hash(password)

def get_user(useremail: str) -> User:
    response = supabase_client.supabase.table("password_with_mail").select("mail", "password").eq("mail", useremail).execute()
    print(response)
    user_data = response.data[0]
    if user_data:
        return User(useremail=user_data.get('mail'), password=user_data.get('password') )
    return User(useremail="", password="")


def authenticate_user(useremail: str, password: str):
    user = get_user(useremail)
    if not user:
        return False
    if not verify_password(password, user.password):
        return False
    return user


def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: Annotated[str, Depends(oauth2_scheme)]):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        useremail: str = payload.get("sub")
        if useremail is None:
            raise credentials_exception
        token_data = TokenData(useremail=useremail)
    except JWTError:
        raise credentials_exception
    user = get_user(useremail=token_data.useremail)
    if user is None:
        raise credentials_exception
    return user


# async def get_current_active_user(
#     current_user: Annotated[User, Depends(get_current_user)],
# ):
#     if current_user.disabled:
#         raise HTTPException(status_code=400, detail="Inactive user")
#     return current_user


@app.post("/token")
async def login_for_access_token(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()],
) -> Token:
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect useremail or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.useremail}, expires_delta=access_token_expires
    )
    return Token(access_token=access_token, token_type="bearer")


# @app.get("/protected-route/")
# async def protected_route(token: str = Depends(oauth2_scheme)):
#     """
#     Захищений маршрут, який можуть використовувати лише авторизовані користувачі.
#     """
#     return {"message": "Це захищений маршрут. Тільки авторизовані користувачі можуть його використовувати."}

