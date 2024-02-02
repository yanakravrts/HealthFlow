from supa_client import SupabaseDBClient, settings

supabase_client = SupabaseDBClient(config=settings)
connection_result = supabase_client.connect()

if connection_result.has_error:
    print(f"Connection failed: {connection_result.notification}")
else:
    print("Connection successful")

class ExtractData:
    def __init__(self, data):
        self.data = data

    def get_user_by_id(self, user_id):
        data = supabase_client.supabase.table("user") \
            .select("*") \
            .eq("id", user_id) \
            .execute()
        return data
    


extractor = ExtractData(supabase_client)

"""user_data = extractor.get_user_by_id(1)
print(user_data)"""

