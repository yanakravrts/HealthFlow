from Backend.other.models import User, TokenData
from cachetools import TTLCache
import random
from Backend.other.error import Error
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from Backend.other.logger_file import logger
from Backend.base.supa_client import supabase_client
from jose import JWTError, jwt
import hashlib
from passlib.context import CryptContext
from datetime import datetime, timedelta, timezone
from fastapi import HTTPException, status
from fastapi.security import OAuth2PasswordBearer
import os
from dotenv import load_dotenv
from jose import JWTError, jwt
from fastapi import HTTPException, Depends
from starlette.status import HTTP_401_UNAUTHORIZED
error = Error()
load_dotenv()

async def oauth2_scheme(token: str = Depends(OAuth2PasswordBearer(tokenUrl="token"))):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except JWTError:
        raise HTTPException(status_code=HTTP_401_UNAUTHORIZED, detail="Invalid or expired token")

    return token

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

ACCESS_TOKEN_EXPIRE_MINUTES = 30
ALGORITHM = os.getenv("ALGORITHM")
SECRET_KEY = os.getenv("SECRET_KEY")


def verify_password(plain_password, hashed_password):
    """
    Verify if the plain password matches the hashed password.

    Args:
        plain_password (str): The plain text password to verify.
        hashed_password (str): The hashed password to compare against.

    Returns:
        bool: True if the plain password matches the hashed password, False otherwise.
    """
    return hashed_password == hashlib.sha256(plain_password.encode()).hexdigest()


def get_password_hash(password):
    """
    Generate a hashed version of the password.

    Args:
        password (str): The password to hash.

    Returns:
        str: The hashed password.
    """
    return pwd_context.hash(password)


def get_user(useremail: str) -> User:
    """
    Retrieve user data from the database based on the email.

    Args:
        useremail (str): The email of the user to retrieve.

    Returns:
        User: The user object if found in the database, otherwise an empty user object.
    """
    response = supabase_client.supabase.table("password_with_mail").select("mail", "password").eq("mail", useremail).execute()
    print(response)
    user_data = response.data[0]
    if user_data:
        return User(useremail=user_data.get('mail'), password=user_data.get('password'))
    return User(useremail="", password="")


def authenticate_user(useremail: str, password: str):
    """
    Authenticate a user based on email and password.

    Args:
        useremail (str): The email of the user to authenticate.
        password (str): The password to verify for the user.

    Returns:
        User: The user object if authentication is successful, False otherwise.
    """
    user = get_user(useremail)
    if not user:
        return False
    if not verify_password(password, user.password):
        return False
    return user


def create_access_token(data: dict, expires_delta: timedelta | None = None):
    """
    Create an access token with the provided data.

    Args:
        data (dict): The data to encode into the token.
        expires_delta (timedelta | None, optional): The expiration time delta for the token. Defaults to None.

    Returns:
        str: The encoded JWT access token.

    Notes:
        The function also saves the token to a binary file named "token.bin".
    """
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    token_bytes = encoded_jwt.encode('utf-8')  # Перетворення рядка токену у байтовий формат
    with open("token.bin", 'wb') as file:
        file.write(token_bytes)
    return encoded_jwt


async def get_current_user(token: str):
    """
    Get the current user based on the provided JWT token.

    Args:
        token (str): The JWT token for authentication.

    Returns:
        User: The user object if authentication is successful.

    Raises:
        HTTPException: If the token is invalid or the user is not authenticated, raises HTTP 401 Unauthorized.
    """
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        if not compare_tokens(token, "token.bin"):
            raise credentials_exception

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


def compare_tokens(user_token: str, file_name: str) -> bool:
    with open(file_name, 'rb') as file:
        stored_token_bytes = file.read()
    stored_token = stored_token_bytes.decode('utf-8')
    return user_token == stored_token


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
