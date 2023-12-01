import psycopg2
from typing import List, Tuple
from dataclasses import dataclass
from config import postgres_config
import datetime
from client_db import DBClient
from tables import UserTable


@dataclass
class ExtractorError(Exception):
    message: str = ''
    def __post_init__(self):
        """
        """
        super().__init__(self.message)
    connection = None

    def __enter__(self):
        try:
            self.connection = psycopg2.connect(**postgres_config)
            return self
        except psycopg2.Error as e:
            raise ExtractorError(f"Failed to connect to the database: {e}")

    def __exit__(self, exc_type, exc_value, traceback):
        if self.connection:
            self.connection.close()

    def execute_query(self, query: str, params: Tuple = None) -> List[dict]:
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(query, params)
                columns = [desc[0] for desc in cursor.description]
                results = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return results
        except psycopg2.Error as e:
            raise ExtractorError(f"Failed to execute the query: {e}")
        

class Extractor:
    def __init__(self):
        self.error = None

    def extract_data(self, query: str, params: Tuple = None) -> List[dict]:
        with ExtractorError() as extractor:
            try:
                results = extractor.execute_query(query, params)
                return results
            except ExtractorError as e:
                self.error = e
                return None
    
    def get_user_by_id(self, user_id: int) -> List[dict]:
       query = "SELECT * FROM \"user\" WHERE id = %s"
       params = (user_id,)
       return self.extract_data(query, params)
    
    def get_lab_in_100m(self,latitude:float,longitude:float)->List[dict]:
        query = "SELECT * FROM \"laboratory\" WHERE calculate_distance(latitude, longitude, %s, %s) <= 100"
        params = (latitude, longitude)
        return self.extract_data(query, params)
    
    def parse_birth_date(self, birth_date_str: str) -> datetime.date:
        return datetime.datetime.strptime(birth_date_str, '%d.%m.%Y').date()
    
    def get_user_older_than(self, year: int) -> List[dict]:
        all_users = self.extract_data("SELECT * FROM \"user\"")
        cutoff_birth_date = datetime.date.today() - datetime.timedelta(days=year*365.25)
        filtered_users = [user for user in all_users if self.parse_birth_date(user[UserTable.BIRTH_DAY]) < cutoff_birth_date]
        return filtered_users
  
    

#output get_user_by_id 
print(*Extractor().get_user_by_id(1) if Extractor().get_user_by_id(1) else "Failed to retrieve user.")

# Output for get_user_older_than
print(*Extractor().get_user_older_than(18) if Extractor().get_user_older_than(18) else "Failed to retrieve user.")



