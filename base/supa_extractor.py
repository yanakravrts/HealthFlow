from supa_client import SupabaseDBClient, settings
from supabase._sync.client import SupabaseException
from postgrest.exceptions import APIError

def fetch_data_from_supabase():
    supabase_client = SupabaseDBClient(config=settings)
    table_name = 'sx'

    try:
        connection_result = supabase_client.connect()
        response = supabase_client.supabase.table(table_name).select("*").execute()

        if response is not None and response.data is not None:
            if not response.data:
                return {"error": f"Table {table_name} is empty or cannot find such data."}
            else:
                # Process the non-empty data as needed
                return {"data": response.data}

    except APIError as api_error:
        # Handle the specific APIError for relation not found
        if 'relation' in str(api_error) and table_name in str(api_error) and 'does not exist' in str(api_error):
            return {"error": f"Table {table_name} does not exist."}
        else:
            # Handle other API errors
            return {"error": f"API Error: {str(api_error)}"}

    except SupabaseException as supabase_exception:
        # Handle other Supabase exceptions
        return {"error": f"Supabase Exception: {str(supabase_exception)}"}

    # Return None in case of an error
    return {"error": "Unknown error occurred."}

data = fetch_data_from_supabase()
print(data)

