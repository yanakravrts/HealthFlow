from pydantic import Field
from pydantic_settings import BaseSettings
from dotenv import load_dotenv

load_dotenv(dotenv_path="data.env")

class HealthFlowBD(BaseSettings):
    host_name:str=Field('localhost',env='HOST')
    user_name:str=Field('postgres',env='USER_NAME_DB')
    database_name:str=Field('HealthFlow',env='DB_NAME')
    user_password:str=Field('070205',env='PASSWORD_DB')
    port:int=Field(5432,env='DB_PORT')
    
postgres_config = HealthFlowBD()
