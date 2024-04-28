from Backend.other.models import User, TokenData
from cachetools import TTLCache
import random
from Backend.other.error import Error
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from Backend.other.logger_file import logger
from Backend.base.supa_client import supabase_client
from Backend.other.hashing_password import hash_password
from jose import JWTError, jwt
import hashlib
from passlib.context import CryptContext
from datetime import datetime, timedelta, timezone
from fastapi import HTTPException, status, Depends
from fastapi.security import OAuth2PasswordBearer
from typing import Annotated
import os
from dotenv import load_dotenv

error = Error()
load_dotenv()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

ACCESS_TOKEN_EXPIRE_MINUTES = 30
ALGORITHM = os.getenv("ALGORITHM")
SECRET_KEY = os.getenv("SECRET_KEY")

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


class EmailService:
    def __init__(self):
        """
        Initializes the EmailService with default values for sender email, sender password,
        and a TTL cache for verification codes.
        """
        self.sender_email = 'spanchak228@gmail.com'
        self.sender_password = 'zwne hugo slfv dacq'
        self.verification_codes = TTLCache(maxsize=100, ttl=300)

    def generate_verification_code(self):
        """
        Generates a random six-digit verification code.

        Returns:
        - str: The generated verification code.
        """
        return str(random.randint(100000, 999999))

    def send_email(self, email):
        """
        Sends an email with a verification code to the specified receiver email.

        Parameters:
        - receiver_email (str): The email address of the recipient.
        - subject (str): The subject of the email.
        - body (str): The body/content of the email.

        Returns:
        - dict: A dictionary containing a message indicating whether the email was sent successfully.
        """
        smtp_server = smtplib.SMTP("smtp.gmail.com", 587)
        smtp_server.starttls()

        try:
            smtp_server.login(self.sender_email, self.sender_password)

            verification_code = self.generate_verification_code()
            self.verification_codes[email] = verification_code

            message = MIMEMultipart()
            message['From'] = self.sender_email
            message['To'] = email


            body_with_code = f"Verification Code: {verification_code}"
            message.attach(MIMEText(body_with_code, 'plain'))

            smtp_server.sendmail(self.sender_email, email, message.as_string())

            return {"message": "Email sent successfully"}
        except Exception as e:
            logger.error(f"An error occurred: {str(e)}")
            return Error.error_500(e, 500, f"An error occurred: {str(e)}")
        finally:
            smtp_server.quit()


# def authenticate_user(email: str, password: str):
#     """
#     Authenticate user based on provided email and password.

#     Args:
#         email (str): The email of the user.
#         password (str): The password of the user.

#     Returns:
#         bool: True if authentication is successful, False otherwise.
#     """
#     try:
#         response = supabase_client.supabase.table("password_with_mail").select("password").eq("mail", email).execute()
#         data = response.data
#         first_item = data[0]
#         password_value = first_item['password']
#         hashed_password_input = hash_password(password)
#         if password_value == hashed_password_input:
#             return True
#         return False
#     except Exception as e:
#         print(f"Error: {e}")
#         return False
