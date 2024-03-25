
from cachetools import TTLCache
import random
from Backend.other.error import Error
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from Backend.other.logger_file import logger
from Backend.base.supa_client import supabase_client
from Backend.other.hashing_password import hash_password

error = Error()

def authenticate_user(email: str, password: str):
    """
    Authenticate user based on provided email and password.

    Args:
        email (str): The email of the user.
        password (str): The password of the user.

    Returns:
        bool: True if authentication is successful, False otherwise.
    """
    try:
        response = supabase_client.supabase.table("password_with_mail").select("password").eq("mail", email).execute()
        data = response.data
        first_item = data[0]
        password_value = first_item['password']
        hashed_password_input = hash_password(password)
        if password_value == hashed_password_input:
            return True
        return False
    except Exception as e:
        print(f"Error: {e}")
        return False
    

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

