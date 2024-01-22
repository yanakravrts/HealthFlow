from fastapi import HTTPException
from fastapi.responses import JSONResponse
from logger_file import logger

class Error:
    @staticmethod
    def error_500(e: Exception, status_code: int, message: str):
        logger.error(f"Internal Server Error: {e}")
        return JSONResponse(content={"message": message}, status_code=500)

    @staticmethod
    def error_404(message: str):
        logger.warning(message)
        return JSONResponse(content={"message": message}, status_code=404)
