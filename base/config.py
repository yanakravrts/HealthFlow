from pydantic import Field
from pydantic_settings import BaseSettings
from dotenv import load_dotenv

load_dotenv(dotenv_path="data.env")

class HealthFlowBD(BaseSettings):
    host:str=Field('localhost',env='HOST')
    user:str=Field('postgres',env='user_DB')
    dbname:str=Field('HealthFlow',env='DB_NAME')
    password:str=Field('070205',env='PASSWORD_DB')
    port:int=Field(5432,env='DB_PORT')
    
postgres_config = HealthFlowBD().model_dump()
