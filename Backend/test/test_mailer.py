import asyncio
from routers.mailer import EmailService, send_email, check_email, EmailSchema
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

    @patch('Backend.app.routers.mailer.email_service')
    def test_send_email_and_check_email_endpoints(self, mock_email_service):
        # Тестування відправки email
        mock_email_service.send_email.return_value = {"message": "Email sent successfully"}

        email_data = EmailSchema(receiver_email="test@example.com", subject="Test Subject", body="Test Body")
        result_send_email = asyncio.run(send_email(email_data))
        self.assertEqual(result_send_email, {"message": "Email sent successfully"})

        # Тестування перевірки email
        mock_email_service.verification_codes.get.return_value = "123456"
        result_check_email_success = asyncio.run(check_email("123456", "test@example.com"))
        self.assertEqual(result_check_email_success, {"message": "Verification successful"})

        mock_email_service.verification_codes.get.return_value = None
        result_check_email_failure = asyncio.run(check_email("123456", "test@example.com"))
        self.assertEqual(result_check_email_failure.status_code, 404)
