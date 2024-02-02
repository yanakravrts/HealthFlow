from pydantic_settings import BaseSettings
from supabase import create_client
from dotenv import load_dotenv
from supabase._sync.client import SupabaseException

load_dotenv()

class Settings(BaseSettings):
    SUPABASE_URL: str
    SUPABASE_KEY: str

class Connection:
    def __init__(self, has_error: bool, notification: str, status: int):
        self.has_error = has_error
        self.notification = notification
        self.status = status

class SupabaseDBClient:
    def __init__(self, config):
        self.supabase = None
        self.supabase_url = config.SUPABASE_URL
        self.supabase_key = config.SUPABASE_KEY

    def connect(self):
        try:
            self.supabase = create_client(self.supabase_url, self.supabase_key)
            return Connection(has_error=False, notification="Connected successfully", status=200)
        except SupabaseException as e:
            error_message = f"Failed to connect to Supabase: {e}"
            return Connection(has_error=True, notification=error_message, status=500)


settings = Settings()
supabase_client = SupabaseDBClient(settings)

connection_result = supabase_client.connect()

if connection_result.has_error:
    print(f"Connection failed: {connection_result.notification}")
else:
    print("Connection successful")