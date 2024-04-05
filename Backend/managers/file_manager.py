import io
import pdfplumber


async def extract_table_from_pdf(file_content: bytes) -> list:
    """
    Extracts table from a PDF file represented as bytes.

    Arguments:
    - file_content: Bytes representing the content of the PDF file.

    Returns:
    - Extracted table from the PDF file as a list.
    """
    with pdfplumber.open(io.BytesIO(file_content)) as pdf:
        for page in pdf.pages:
            table = page.extract_table()
            if table:
                for row in table:
                    print(row)
    return table

a = 2