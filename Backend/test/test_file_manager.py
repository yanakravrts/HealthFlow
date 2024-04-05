# import pytest
# from unittest.mock import MagicMock, patch
# from Backend.managers.file_manager import extract_table_from_pdf


# @pytest.mark.asyncio
# async def test_extract_text_from_pdf():
#     with patch('Backend.managers.file_manager.pdfplumber.open') as mock_pdfplumber_open, \
#          patch('Backend.managers.file_manager.io.BytesIO') as mock_bytesio:

#         mock_pdf = MagicMock()
#         mock_pdf.pages = [MagicMock() for _ in range(3)]
#         mock_pdf.pages[0].extract_text.return_value = "Text from page 1"
#         mock_pdf.pages[1].extract_text.return_value = "Text from page 2"
#         mock_pdf.pages[2].extract_text.return_value = "Text from page 3"

#         mock_pdfplumber_open.return_value.__enter__.return_value = mock_pdf

#         extracted_text = await extract_table_from_pdf(b"")

#         assert extracted_text == "Text from page 1Text from page 2Text from page 3"
#         mock_pdfplumber_open.assert_called_once_with(mock_bytesio.return_value)
