from fastapi import APIRouter, HTTPException, Query
from pydantic import EmailStr
from Backend.other.logger_file import logger
from Backend.other.error import Error
from Backend.other.models import EmailSchema
from Backend.managers.mailer_manager import authenticate_user, EmailService
from Backend.base.supa_client import supabase_client
from Backend.other.hashing_password import hash_password
from datetime import datetime, timezone

router = APIRouter()
error = Error()

email_service = EmailService()

@router.post("/send_email/", tags=["mailer"])
async def send_email(email: EmailSchema):
    """
    Endpoint to send an email with a verification code.

    Parameters:
    - email (EmailSchema): The email data including receiver email, subject, and body.

    Returns:
    - dict: A dictionary containing a message indicating whether the email was sent successfully.
    """
    logger.info(f"Sending email to {email.receiver_email}")
    try:
        return email_service.send_email(email.receiver_email, email.subject, email.body)
    except HTTPException as e:
        return e


@router.post("/check_email/", tags=["mailer"])
async def check_email(verification_code: str, receiver_email: EmailStr):
    """
    Endpoint to check the verification code.

    Parameters:
    - verification_code (str): The verification code entered by the user.
    - receiver_email (EmailStr): The email address associated with the verification code.

    Returns:
    - dict: A dictionary containing a message indicating the result of the verification.
    """
    stored_code = email_service.verification_codes.get(receiver_email)
    if stored_code and stored_code == verification_code:
        logger.info(f"Verification successful for {receiver_email}")
        return {"message": "Verification successful"}
    else:
        return error.error_404(f"Invalid verification code or email")


@router.post("/login", tags=["mailer"])
async def login(email: str = Query(..., description="User email"), 
                password: str = Query(..., description="User password")):
    """
    Logs in a user with the provided credentials.

    Args:
        email (str): The user's email.
        password (str): The user's password.

    Returns:
        dict: A message indicating whether the login was successful.
    """
    try:
        if not authenticate_user(email, password):
            return error.error_404(f"Invalid password or email")
        logger.info(f"Login successful")
        return {"message": "Login successful"}
    except Exception as e:
        return error.error_500(e, f"An error occurred while trying to identify the user: {str(e)}")


@router.post("/users", tags=["mailer"])
async def add_user(email: str = Query(..., description="User email"),
                    password: str = Query(..., description="User password")):
    """
    Adds a new user to the database.

    Args:
        email (str): The user's email.
        password (str): The user's password.

    Returns:
        dict: The response from the database after adding the user.
    """
    try:
        hashed_password = hash_password(password)
        response = supabase_client.supabase.table("password_with_mail").insert({"mail": email, "password": hashed_password}).execute()
        return response
    except Exception as e:
        return error.error_500(e, f"An error occurred when trying to add a user to the database: {str(e)}")


@router.post("/create_profile", tags=["mailer"])
async def create_user(name: str = Query(..., description="User name"),
                      sex_id: int = Query(..., description="User sex ID"),
                      email: str = Query(..., description="User email"),
                      birth_day_timestamp: int = Query(..., description="User birth day as Unix timestamp")):
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