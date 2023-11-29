import psycopg2
from typing import List
from dataclasses import dataclass
from config import postgres_config

@dataclass
class Connection:
    has_error: bool
    notification: str
    status: int

class ClientErrorDB:
    def __init__(self, notification: str):
        self.notification = notification

@dataclass
class ResponseFromDB:
    rows: List[dict]
    KeyError: ClientErrorDB = None

class DBClient:
    def __init__(self, config):
        self.connection = None
        self.host_name = config.host_name
        self.user_name = config.user_name
        self.user_password = config.user_password
        self.database_name = config.database_name

    def connect(self):

        try:

            connection_string = (
                f"host={self.host_name} "
                f"user={self.user_name} "
                f"password={self.user_password} "
                f"dbname={self.database_name}"
            )
            self.connection = psycopg2.connect(connection_string)
            return Connection(has_error=False, notification="Connected successfully", status=200)
        
        except psycopg2.Error as e:
            
            error_message = f"Error connecting to the database: {str(e)}"
            return Connection(has_error=True, notification=error_message, status=500)

    def execute_query(self, sql_query):

        try:

            cursor = self.connection.cursor()
            cursor.execute(sql_query)
            rows = [dict(zip([column[0] for column in cursor.description], row)) for row in cursor.fetchall()]
            return ResponseFromDB(rows=rows)
        
        except psycopg2.Error as e:

            error_message = f"Error executing SQL query: {str(e)}"
            return ResponseFromDB(error=ClientErrorDB(notification=error_message))
        
        finally:

            cursor.close()

    def is_connected(self):
        return self.connection is not None


db_client = DBClient(postgres_config)
connection_result = db_client.connect()

if connection_result.has_error:
    print(f"Connection failed: {connection_result.notification}")
else:
    print("Connection successful")


