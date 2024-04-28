from Backend.routers.mailer import EmailService, send_email, check_email
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

    @patch('Backend.routers.mailer.email_service')
    async def test_send_email_success(self, mock_email_service):
        # Підготовка
        mock_email_service.send_email.return_value = {"message": "Email sent successfully"}
        email_data = {"email": "test@example.com", "subject": "Test Subject", "body": "Test Body"}
        
        # Виклик функції
        result_send_email = await send_email(email_data)
        
        # Перевірка результату
        self.assertEqual(result_send_email, {"message": "Email sent successfully"})
        mock_email_service.send_email.assert_called_once_with(email_data)

    async def test_check_email_success(self):
        # Підготовка
        mock_email_service = MagicMock()
        mock_email_service.verification_codes = {"test@example.com": "123456"}
        verification_code = "123456"
        email = "test@example.com"
        
        # Виклик функції
        result_check_email_success = await check_email(verification_code, email)
        
        # Перевірка результату
        self.assertEqual(result_check_email_success, {"message": "Verification successful"})
        mock_email_service.verification_codes.get.assert_called_once_with(email)

    async def test_check_email_failure(self):
        # Підготовка
        mock_email_service = MagicMock()
        mock_email_service.verification_codes = {"test@example.com": "123456"}
        verification_code = "654321"  # неправильний код
        email = "test@example.com"
        
        # Виклик функції
        result_check_email_failure = await check_email(verification_code, email)
        
        # Перевірка результату
        self.assertEqual(result_check_email_failure.status_code, 404)
        mock_email_service.verification_codes.get.assert_called_once_with(email)