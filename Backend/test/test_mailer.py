import asyncio
from Backend.app.routers.mailer import EmailService, send_email, check_email,EmailSchema
from Backend.other.logger_file import logger
from Backend.other.error import Error
import unittest
from unittest.mock import patch, MagicMock

class TestEmailService(unittest.TestCase):
    @patch('smtplib.SMTP')
    def test_send_email_success(self, mock_smtp):
        email_service = EmailService()
        mock_smtp_instance = MagicMock()
        mock_smtp.return_value = mock_smtp_instance

        result = email_service.send_email("test@example.com", "Test Subject", "Test Body")

        self.assertEqual(result, {"message": "Email sent successfully"})
        mock_smtp_instance.starttls.assert_called_once()
        mock_smtp_instance.login.assert_called_once_with(email_service.sender_email, email_service.sender_password)
        mock_smtp_instance.sendmail.assert_called_once()
        mock_smtp_instance.quit.assert_called_once()

class TestEmailEndpoints(unittest.TestCase):
    @patch('Backend.app.routers.mailer.email_service')
    def test_send_email_endpoint(self, mock_email_service):
        mock_email_service.send_email.return_value = {"message": "Email sent successfully"}

        email_data = EmailSchema(receiver_email="test@example.com", subject="Test Subject", body="Test Body")
        result = asyncio.run(send_email(email_data))

        self.assertEqual(result, {"message": "Email sent successfully"})
    @patch('Backend.app.routers.mailer.email_service')
    def test_check_email_endpoint_success(self, mock_email_service):
        mock_email_service.verification_codes.get.return_value = "123456"

        result = asyncio.run(check_email("123456", "test@example.com"))  

        self.assertEqual(result, {"message": "Verification successful"})

    @patch('Backend.app.routers.mailer.email_service')
    def test_check_email_endpoint_failure(self, mock_email_service):
        mock_email_service.verification_codes.get.return_value = None

        result = asyncio.run(check_email("123456", "test@example.com"))  

        self.assertEqual(result.status_code, 404)  # Assuming Error.error_404 returns a JSONResponse with status code 404
