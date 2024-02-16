from fastapi.responses import JSONResponse
from logger_file import logger

class Error:
    @staticmethod
    def error_500(e: Exception, message: str):
        logger.error(f"Internal Server Error: {e}")
        return JSONResponse(content={"message": message}, status_code=500)
    
    
    @staticmethod
    def error_422(message: str):
        logger.error(message)
        return JSONResponse(content={"message": message}, status_code=422)
    
    
    @staticmethod
    def error_404(message: str):
        logger.warning(message)
        return JSONResponse(content={"message": message}, status_code=404)
    

    @staticmethod
    def error_400(message: str):
        logger.warning(message)
        return JSONResponse(content={"message": message}, status_code=400)
