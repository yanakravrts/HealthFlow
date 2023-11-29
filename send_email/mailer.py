from fastapi import FastAPI
from pydantic import BaseModel
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

app = FastAPI()


class EmailSchema(BaseModel):
    receiver_email: str
    subject: str
    body: str


@app.post("/send_email/")
async def send_email(email: EmailSchema):
    smtp_server = smtplib.SMTP("smtp.gmail.com", 587)
    smtp_server.starttls()

    sender_email = 'spanchak228@gmail.com'
    sender_password = 'a0612096Kvv'
    receiver_email = email.receiver_email
    subject = email.subject
    body = email.body

    try:

        smtp_server.login(sender_email, sender_password)


        message = MIMEMultipart()
        message['From'] = sender_email
        message['To'] = receiver_email
        message['Subject'] = subject
        message.attach(MIMEText(body, 'plain'))


        smtp_server.sendmail(sender_email, receiver_email, message.as_string())
        return {"message": "Email sent successfully"}
    except Exception as e:
        return {"error": f"An error occurred: {str(e)}"}
    finally:

        smtp_server.quit()
