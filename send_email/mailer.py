from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import random

app = FastAPI()
def generate_verification_code():
    return str(random.randint(100000, 999999))
class EmailSchema(BaseModel):
    receiver_email: EmailStr
    subject: str
    body: str
@app.post("/send_email/")
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