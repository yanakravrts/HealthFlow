import unittest
from unittest.mock import MagicMock
from Backend.managers.file_manager import extract_table_from_pdf


class TestExtractTableFromPDF(unittest.IsolatedAsyncioTestCase):
    async def test_extract_table_from_pdf(self):
        mock_pdf_content = b"Sample PDF content"
        expected_table = [
            ["Header1", "Header2", "Header3"],
            ["Data1", "Data2", "Data3"],
            ["Data4", "Data5", "Data6"]
        ]
        

        with unittest.mock.patch('pdfplumber.open') as mock_open:
            mock_page = MagicMock()
            mock_page.extract_table.return_value = expected_table
            mock_pdf = MagicMock()
            mock_pdf.pages = [mock_page]
            mock_open.return_value.__enter__.return_value = mock_pdf
            result = await extract_table_from_pdf(mock_pdf_content)
            self.assertEqual(result, expected_table)
