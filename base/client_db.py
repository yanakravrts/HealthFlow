import psycopg2
from typing import List
from dataclasses import dataclass
from config import postgres_config


@dataclass
class Connection:
    """
    Data class which represents the result of a database connection

    Attributes:
    - has_error (bool): Indicates error in connection
    - notification (str): Message about connection status
    - status (int): An integer representing connection status
    """
    has_error: bool
    notification: str
    status: int


class ClientErrorDB:
    def __init__(self, notification: str):
        """
        Class represent errors to database client
        
        Attributes:
        - notification (str): error message
        """
        self.notification = notification


@dataclass
class ResponseFromDB:
    """
    Data class which represents the respince from database query

    Attributes:
    - rows (List[dict]): A list of dictionaries representing the query results
    - KeyError (ClientErrorDB): An optional instance of ClientErrorDB indicating a key error in the query
    """
    rows: List[dict]
    KeyError: ClientErrorDB = None


class DBClient:
    """
    Class representing a client for interacting with a PostgreSQL database.

    Attributes:
    - connection (psycopg2.extensions.connection): A connection object representing the database connection
    - host_name (str): The hostname of the database server
    - user_name (str): The username for connecting to the database
    - user_password (str): The password for connecting to the database
    - database_name (str): The name of the database
    """
    def __init__(self, config):
        self.connection = None
        self.host_name = config['host']
        self.user_name = config['user']
        self.user_password = config['password']
        self.database_name = config['dbname']

    def connect(self):
        """
        Connection to te dstsbase

        Returns:
               - Connection: An instance of the Connection class representing the connection result
        """
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
        """
        Executes PostgreSQL query and returns response
        
        Args:
            - sql_query(str): query to be executed

        Returns:
               - ResponseFromDB :     An instance of the ResponseFromDB class representing the query response
        """
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
        """
        Checks if client connected to the dstsbase

        Returns:
               - bool: True-connected , False- not connected
        """
        return self.connection is not None


db_client = DBClient(postgres_config)
connection_result = db_client.connect()

if connection_result.has_error:
    print(f"Connection failed: {connection_result.notification}")
else:
    print("Connection successful")
