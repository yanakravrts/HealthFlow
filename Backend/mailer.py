from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import random
from cachetools import TTLCache

class EmailService:
    def __init__(self):
        self.sender_email = 'spanchak228@gmail.com'
        self.sender_password = 'zwne hugo slfv dacq'
        self.verification_codes = TTLCache(maxsize=100, ttl=300)

    def generate_verification_code(self):
        return str(random.randint(100000, 999999))

    def send_email(self, receiver_email, subject, body):
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
            raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
        finally:
            smtp_server.quit()

class EmailSchema(BaseModel):
    receiver_email: EmailStr
    subject: str
    body: str

app = FastAPI()
email_service = EmailService()

@app.post("/send_email/")
async def send_email(email: EmailSchema):
    return email_service.send_email(email.receiver_email, email.subject, email.body)

@app.post("/check_email/")
async def check_email(verification_code: str, receiver_email: EmailStr):
    stored_code = email_service.verification_codes.get(receiver_email)
    if stored_code and stored_code == verification_code:
        return {"message": "Verification successful"}
    else:
        raise HTTPException(status_code=400, detail="Invalid verification code or email")