from fastapi import FastAPI, Query
import json
from time import time
from models import Point
from logger_file import logger
import sys
from laboratories_manager import points_in_radius
sys.path.append(r'C:\code\HealthFlow\base')  # тут потрібно вказати шлях до папки base на вашому комп'ютері
from supa_client import supabase_client
from error import Error

error = Error()

app = FastAPI()


@app.post("/laboratories")

async def add_event(region: str = Query(..., description="Name of the region"),
                    center_lat: float = Query(..., description="Latitude of the center point"),
                    center_lon: float = Query(..., description="Longitude of the center point"),
                    radius: float = Query(..., description="Radius in kilometers")):
    """
Endpoint: /laboratories

Description:
Add a center point to get labs within a given radius from a given center point.

Parameters:
- region: Name of the region.
- center_lat: Latitude of the center point in degrees.
- center_lon: Longitude of the center point in degrees.
- radius: Radius in kilometers.

Returns:
- List of laboratories within the specified radius from the center point.

"""
    start = time()
    try:
        response = supabase_client.supabase.table("laboratory") \
            .select("id", "name", "latitude", "longitude") \
            .eq("region", region).execute()

        data = response.model_dump_json()
        lab_data = [Point(id=item["id"], name=item["name"], latitude=item["latitude"], longitude=item["longitude"]) for
                    item in json.loads(data)["data"]]

        result = points_in_radius(center_lat, center_lon, radius, lab_data)

        if not result:
            error.error_404(f"No laboratories found within the specified radius")
        print(time()- start," worktime")
        return result
    except Exception as e:
        error.error_500(e, f"An error occurred while retrieving laboratories within radius: {e}")
        