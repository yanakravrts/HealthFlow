from supa_client import SupabaseDBClient, settings
from supabase._sync.client import SupabaseException
from postgrest.exceptions import APIError
from logger_file import MyLogger

def fetch_data_from_supabase():
    supabase_client = SupabaseDBClient(config=settings)
    table_name = 'sex'

    logger = MyLogger(__name__)

    try:
        connection_result = supabase_client.connect()
        response = supabase_client.supabase.table(table_name).select("*").execute()

        if response is not None and response.data is not None:
            if not response.data:
                logger.info(f"Table {table_name} is empty or cannot find such data.")
            else:
                # Process the non-empty data as needed
                logger.info(f"Data retrieved: ")
                return response.data

    except APIError as api_error:
        # Handle the specific APIError for relation not found
        if 'relation' in str(api_error) and table_name in str(api_error) and 'does not exist' in str(api_error):
            logger.error(f"Table {table_name} does not exist.")
        else:
            # Handle other API errors
            logger.error(f"API Error: {str(api_error)}")

    except SupabaseException as supabase_exception:
        # Handle other Supabase exceptions
        logger.error(f"Supabase Exception: {str(supabase_exception)}")

    return None  


data = fetch_data_from_supabase()

print(data)
