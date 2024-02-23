from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import random
from cachetools import TTLCache
from Backend.other.logger_file import logger
from Backend.other.error import Error


router = APIRouter()


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

    def send_email(self, receiver_email, subject, body):
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
            self.verification_codes[receiver_email] = verification_code

            message = MIMEMultipart()
            message['From'] = self.sender_email
            message['To'] = receiver_email
            message['Subject'] = subject

            body_with_code = f"Verification Code: {verification_code}"
            message.attach(MIMEText(body_with_code, 'plain'))

            smtp_server.sendmail(self.sender_email, receiver_email, message.as_string())

            return {"message": "Email sent successfully"}
        except Exception as e:
            logger.error(f"An error occurred: {str(e)}")
            return Error.error_500(e, 500, f"An error occurred: {str(e)}")
        finally:
            smtp_server.quit()

class EmailSchema(BaseModel):
    """
    Pydantic model representing the structure of email data.
    """
    receiver_email: EmailStr
    subject: str
    body: str

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
        return Error.error_404(f"Invalid verification code or email")
