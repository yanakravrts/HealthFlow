import psycopg2
from typing import List, Tuple
from dataclasses import dataclass
from config import postgres_config
import datetime
from client_db import DBClient
from tables import UserTable
import tables

@dataclass
class ExtractorError(Exception):
    """
    A class used to represent ExtractorError and exeptions for errors which might occur in this class

    Attributes:
    - message (str): String which represent error message
    """
    message: str = ''
    def __post_init__(self):
        """
        Innitialization method for class
        """
        super().__init__(self.message)
    connection = None

    def __enter__(self):
        """
        Method to establish connection to database

        Raises:
        - ExtractorError: If there are any errors in connecting to the database.
        """
        try:
            self.connection = psycopg2.connect(**postgres_config)
            return self
        except psycopg2.Error as e:
            raise ExtractorError(f"Failed to connect to the database: {e}")

    def __exit__(self, exc_type, exc_value, traceback):
        """
        Method to close connection with database
        """
        if self.connection:
            self.connection.close()

    def execute_query(self, query: str, params: Tuple = None) -> List[dict]:
        """
        Method to execute PostgreSQL query 

        Args:
            - query(str): PostgreSQL query to be executed 
            - params(Tuple): Optional parameters for the query

        Returns:
               - list of dictionaries: as a query result 

        Raises:
               - error if something went wrong with execution of the query             
        """
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(query, params)
                columns = [desc[0] for desc in cursor.description]
                results = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return results
        except psycopg2.Error as e:
            raise ExtractorError(f"Failed to execute the query: {e}")
        

class Extractor:
    """
    Class extracts data from database using PostgreSQL queries

    Attributes:
     - error: an instance of ExtractorError class to capture errors
    """
    def __init__(self):
        """
        Initialization of the Extractor class

        """
        self.error = None

    def extract_data(self, query: str, params: Tuple = None) -> List[dict]:
        """
        Method for extracting data from the database with use of PostgreSQL query and parameters
        
        Args:
            - query (str): PostgreSQL query to be executed
            - params (Tuple): Optional parameters for the query

        Returns:
               - list of dictionaries : as query result 
               If any error occur, None is returned
        """
        with ExtractorError() as extractor:
            try:
                results = extractor.execute_query(query, params)
                return results
            except ExtractorError as e:
                self.error = e
                return None
    
    def get_user_by_id(self, user_id: int) -> List[dict]:
       """
       Retrieve user information by user ID

       Args:
           - user_id (int): The ID of the user to retrieve
       
       Returns: 
              - list of dictionaries: which represents user info
       """
       query = "SELECT * FROM \"user\" WHERE id = %s"
       params = (user_id,)
       return self.extract_data(query, params)
    
    def get_lab_in_100m(self,latitude:float,longitude:float)->List[dict]:
        """
        Retrieve laboratories within 100 meters of the specified coordinates 
        
        Args:
            - latitude (float):The latitude of the target location
            - longitude (float): The longitude of the target location
        """
        #query = "SELECT * FROM \"laboratory\" WHERE calculate_distance(latitude, longitude, %s, %s) <= 100"
        query = f"SELECT * FROM {tables.LaboratoryTable} WHERE calculate_distance(latitude, longitude, %s, %s) <= 100"
        params = (latitude, longitude)
        return self.extract_data(query, params)
    
    def parse_birth_date(self, birth_date_str: str) -> datetime.date:
        """
        Parse a birth string into datetime.date object

        Args:
            - birt_date_str (str): A string representing the birth date in the format '%d.%m.%Y'
            
        Returns: 
               - datetime.date: A datetime.date object representing the parsed birth date   
        """
        return datetime.datetime.strptime(birth_date_str, '%d.%m.%Y').date()
    
    def get_user_older_than(self, year: int) -> List[dict]:
        """
        Retrive users older than the number of years

        Args:
            - year (int): number of tears to consider

        Returns:
             - list of dictionaries: as user older than the number of years
        """
        all_users = self.extract_data("SELECT * FROM \"user\"")
        cutoff_birth_date = datetime.date.today() - datetime.timedelta(days=year*365.25)
        filtered_users = [user for user in all_users if self.parse_birth_date(user[UserTable.BIRTH_DAY]) < cutoff_birth_date]
        return filtered_users
    
    def user_exist_by_email(self,email:str)->bool:
        """
        Check if user exist by email

        Args:
            - email(str): the email addres to check 

        Returns:
               - bool: True - user exists, False - doesn't exist 
        """
        query=f"SELECT * FROM {tables.UserTable} WHERE {tables.UserTable.EMAIL} = %s"
        params=(email,)
        result=self.extract_data(query,params)
        return result is not None and len(result)>0
      
    def active_blood_needs(self,blood_type:float)->List[dict]:
        """
        Get active blood needs for a specific blood types

        Args:
            - blood_type (str): The blood type to search for

        Returns:
            - list of dictionaries: Active blood needs with the specified blood type
        """
        query = f"SELECT {tables.BloodBankTable.NAME}, {tables.BloodBankTable.ADDRESS} FROM {tables.BloodNeedTable} JOIN {tables.BloodBankTable} ON {tables.BloodBankTable.ID} = {tables.BloodNeedTable.BANK_ID} WHERE {tables.BloodNeedTable.BLOOD_TYPE} = %s {tables.BloodNeedTable.TIMESTAMP}::DATE >= CURRENT_DATE()"
        params = (blood_type,)
        return self.extract_data(query, params)

    def analysis_results(self,user_id:int)->List[dict]:
        """
        Get user's analysis results by id 

        Args:
            - user_id(int): The ID of the user to retrieve

        Returns:
               - list of dictionaries: User analysis info    
        """
        query = f"SELECT {tables.UserTable.NAME}, {tables.UserAnalysisTable.ANALYSIS_ID}, {tables.UserAnalysisTable.ACTUAL_VALUE}, {tables.UserAnalysisTable.TIMESTAMP} FROM {tables.UserTable} JOIN {tables.UserAnalysisTable} ON {tables.UserTable.ID} = {tables.UserAnalysisTable.USER_ID} WHERE {tables.UserTable.ID} = %s"
        params = (user_id,)
        return self.extract_data(query, params)

    def lab_coordinates(self,lab_id:int)->List[dict]:
        """
        Get lab's coordanates by id 

        Args: 
            - lad_id(int): the id of lab to retrieve

        Returns:
               - latitude and longitude      
        """
        query = f"SELECT {tables.LaboratoryTable.LATITUDE}, {tables.LaboratoryTable.LONGITUDE} FROM {tables.LaboratoryTable} WHERE {tables.LaboratoryTable.ID} = %s "
        params = (lab_id,)
        return self.extract_data(query,params)

print(Extractor().lab_coordinates(1))
print(Extractor().analysis_results(1))
blood_type="2+"
print(Extractor().active_blood_needs(blood_type))
#output user_exist_by_email
print(Extractor().user_exist_by_email("olgam@gmail.com"))
#output get_user_by_id 
print(*Extractor().get_user_by_id(1) if Extractor().get_user_by_id(1) else "Failed to retrieve user.")
# Output for get_user_older_than
print(*Extractor().get_user_older_than(18) if Extractor().get_user_older_than(18) else "Failed to retrieve user.")


