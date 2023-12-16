from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import random
from cachetools import TTLCache

app = FastAPI()


verification_codes = TTLCache(maxsize=100, ttl=300)

def generate_verification_code():
    return str(random.randint(100000, 999999))

class EmailSchema(BaseModel):
    receiver_email: EmailStr
    subject: str
    body: str

@app.post("/Backend/")
async def send_email(email: EmailSchema):
    smtp_server = smtplib.SMTP("smtp.gmail.com", 587)
    smtp_server.starttls()

    sender_email = 'spanchak228@gmail.com'
    sender_password = 'zwne hugo slfv dacq'
    receiver_email = email.receiver_email
    subject = email.subject
    body = email.body

    try:
        smtp_server.login(sender_email, sender_password)

        verification_code = generate_verification_code()
        verification_codes[receiver_email] = verification_code  # Store the code with email

        message = MIMEMultipart()
        message['From'] = sender_email
        message['To'] = receiver_email
        message['Subject'] = subject

        body_with_code = f"Verification Code: {verification_code}"
        message.attach(MIMEText(body_with_code, 'plain'))

        smtp_server.sendmail(sender_email, receiver_email, message.as_string())

        return {"message": "Email sent successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
    finally:
        smtp_server.quit()

@app.post("/check_email/")
async def check_email(verification_code: str, receiver_email: EmailStr):
    stored_code = verification_codes.get(receiver_email)
    if stored_code and stored_code == verification_code:
        return {"message": "Verification successful"}
    else:
        raise HTTPException(status_code=400, detail="Invalid verification code or email")

