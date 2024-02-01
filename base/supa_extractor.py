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
    
    # def get_lab_coordinate(self):
    #     data = supabase_client.supabase.table("laboratory")\
    #     .select("id","name","latitude","longitude").execute()
    #     return data

    
    # def get_lab_coordinate(self):
    #     region = input("Введіть назву області: ")
    #     data = supabase_client.supabase.table("laboratory")\
    #         .select("id", "name", "latitude", "longitude")\
    #         .eq("region", region).execute()
    #     return data
    


extractor = ExtractData(supabase_client)

# data = extractor.get_lab_coordinate().data
# print(len(data))
# print(data)
"""user_data = extractor.get_user_by_id(1)
print(user_data)"""

