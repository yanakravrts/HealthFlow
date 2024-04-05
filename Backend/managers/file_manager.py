import io
import pdfplumber


async def extract_text_from_pdf(file_content: bytes) -> str:
    """
    Extracts text from a PDF file represented as bytes.

    Arguments:
    - file_content: Bytes representing the content of the PDF file.

    Returns:
    - Extracted text from the PDF file as a string.
    """
    with pdfplumber.open(io.BytesIO(file_content)) as pdf:
        text = ""
        for page in pdf.pages:
            text += page.extract_text(layout=True)
    return text
