from fastapi import APIRouter, HTTPException, Query, status, Depends
from pydantic import EmailStr
from Backend.other.logger_file import logger
from Backend.other.error import Error
from Backend.other.models import Token
from Backend.managers.mailer_manager import authenticate_user, EmailService, create_access_token, ACCESS_TOKEN_EXPIRE_MINUTES, oauth2_scheme
from Backend.base.supa_client import supabase_client
from Backend.other.hashing_password import hash_password
from datetime import datetime, timedelta, timezone
from typing import Annotated
from fastapi.security import OAuth2PasswordRequestForm


router = APIRouter()
error = Error()
email_service = EmailService()


@router.post("/send_email/", tags=["mailer"])
async def send_email(
    email: str = Query(..., description="User email"),
):
    """
    Endpoint to send an email with a verification code.

    Parameters:
    - email (EmailSchema): The email data including receiver email, subject, and body.
    - mail (str): The email address of the user.
    - subject (str): The subject of the email.
    - body (str): The body of the email.

    Returns:
    - dict: A dictionary containing a message indicating whether the email was sent successfully.
    """
    logger.info(f"Sending email to {email}")
    try:
        return email_service.send_email(email)
    except HTTPException as e:
        return e


@router.post("/check_email/", tags=["mailer"])
async def check_email(
    verification_code: str,
    email: EmailStr,
    password: str = None
):
    """
    Endpoint to check the verification code.

    Parameters:
    - verification_code (str): The verification code entered by the user.
    - receiver_email (EmailStr): The email address associated with the verification code.
    - password (str, optional): The password entered by the user.

    Returns:
    - dict: A dictionary containing a message indicating the result of the verification.
    """
    stored_code = email_service.verification_codes.get(email)
    if stored_code and stored_code == verification_code:
        logger.info(f"Verification successful for {email}")
        if password:
            try:
                hashed_password = hash_password(password)
                supabase_client.supabase.table("password_with_mail").insert({"mail": email, "password": hashed_password}).execute()
                return {"message": "Email and password have been added successfully"}
            except Exception as e:
                return error.error_500(e, f"An error occurred when trying to add a user to the database: {str(e)}")
        else:
            return {"message": "Verification successful"}
    else:
        return error.error_404("Invalid verification code or email")


@router.post("/token", tags=["mailer"])
async def login_for_access_token(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()]
) -> Token:
    """
    Endpoint to authenticate users and generate access tokens.

    Args:
        form_data (OAuth2PasswordRequestForm): Form data containing useremail and password.

    Returns:
        Token: The generated access token.

    Raises:
        HTTPException: If the user authentication fails, raises HTTP 401 Unauthorized.
    """
    user = authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.useremail}, expires_delta=access_token_expires
    )
    return Token(access_token=access_token, token_type="bearer")


@router.post("/create_profile", tags=["mailer"])
async def create_user(name: str = Query(..., description="User name"),
                      sex_id: int = Query(..., description="User sex ID"),
                      email: str = Query(..., description="User email"),
                      birth_day_timestamp: int = Query(..., description="User birth day as Unix timestamp"),
                      token: str = Depends(oauth2_scheme)):
    """
    Creates a user profile with the provided information.

    Args:
        name (str): The user's name.
        sex_id (int): The user's sex ID.
        email (str): The user's email.
        birth_day_timestamp (int): The user's birth day as Unix timestamp.

    Returns:
        dict: The response from the database after creating the user profile.
    """
    try:
        birth_day = datetime.fromtimestamp(birth_day_timestamp, tz=timezone.utc).strftime('%Y-%m-%d')
        response = supabase_client.supabase.table("user").insert({
            "name": name,
            "sex_id": sex_id,
            "email": email,
            "birth_day": birth_day
        }).execute()
        return response
    except Exception as e:
        return error.error_500(e, f"An error occurred while trying to create a user: {str(e)}")

# @router.post("/login", tags=["mailer"])
# async def login(email: str = Query(..., description="User email"),
#                 password: str = Query(..., description="User password")):
#     """
#     Logs in a user with the provided credentials.

#     Args:
#         email (str): The user's email.
#         password (str): The user's password.

#     Returns:
#         dict: A message indicating whether the login was successful.
#     """
#     try:
#         if not authenticate_user(email, password):
#             return error.error_404("Invalid password or email")
#         logger.info("Login successful")
#         return {"message": "Login successful"}
#     except Exception as e:
#         return error.error_500(e, f"An error occurred while trying to identify the user: {str(e)}")


# @router.post("/users", tags=["mailer"])
# async def add_user(email: str = Query(..., description="User email"),
#                    password: str = Query(..., description="User password")):
#     """
#     Adds a new user to the database.

#     Args:
#         email (str): The user's email.
#         password (str): The user's password.

#     Returns:
#         dict: The response from the database after adding the user.
#     """
#     try:
#         hashed_password = hash_password(password)
#         response = supabase_client.supabase.table("password_with_mail").insert({"mail": email, "password": hashed_password}).execute()
#         return response
#     except Exception as e:
#         return error.error_500(e, f"An error occurred when trying to add a user to the database: {str(e)}")
