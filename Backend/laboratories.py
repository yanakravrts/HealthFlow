from fastapi import FastAPI, Query
import math
import json
from time import time
from models import Point
from logger_file import logger
from fastapi.responses import JSONResponse
import sys
sys.path.append(r'base\supa_client.py')  
from supa_client import supabase_client
from error import Error

error = Error()

app = FastAPI()


@app.post("/laboratories")
async def add_event(region: str = Query(..., description="Name of the region"),
                    center_lat: float = Query(..., description="Latitude of the center point"),
                    center_lon: float = Query(..., description="Longitude of the center point"),
                    radius: float = Query(..., description="Radius in kilometers")):
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
        
# @app.post("/laboratories")
# async def search_laboratories(region: str = Query(..., description="Name of the region"),
#                     center_lat: float   = Query(..., description="Latitude of the center point"),
#                     center_lon: float = Query(..., description="Longitude of the center point"),
#                     radius: float = Query(..., description="Radius in kilometers")):
#     try:
#         response = supabase_client.supabase.table("laboratory") \
#             .select("id", "name", "latitude", "longitude") \
#             .eq("region", region).execute()

#         data = response.model_dump_json()
#         lab_data = [Point(id=item["id"], name=item["name"], latitude=item["latitude"], longitude=item["longitude"]) for item in json.loads(data)["data"]]

#         result = points_in_radius(center_lat, center_lon, radius, lab_data)
        
#         if not result:
#             logger.warning(f"No laboratories found within the specified radius")
#             return JSONResponse(content={"message": f"No laboratories found within the specified radius"}, status_code=404)
        
#         return result
#     except Exception as e:
#         logger.error(f"An error occurred while retrieving laboratories within radius: {e}")
#         return JSONResponse(content={"message": f"Internal Server Error: {e}"}, status_code=500)


# @app.post("/laboratories")
# async def add_event(center_lat: float, center_lon: float, radius: float):
#     try:
#         lab_data = [Point(**item) for item in data]
#         result = points_in_radius(center_lat, center_lon, radius, lab_data)
#         if not result:
#             logger.warning(f"No laboratories found within the specified radius")
#             return JSONResponse(content={"message": f"No laboratories found within the specified radius"}, status_code=404)
#         return result
#     except Exception as e:
#         logger.error(f"An error occurred while retrieving laboratories within radius: {e}")
#         return JSONResponse(content={"message": f"Internal Server Error: {e}"}, status_code=500)
    
    
def haversine(lat1, lon1, lat2, lon2):
    R = 6371
    lat1, lon1, lat2, lon2 = map(math.radians, [lat1, lon1, lat2, lon2])
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
    distance = 2 * R * math.asin(math.sqrt(a))
    return distance


def points_in_radius(center_lat, center_lon, radius, lab_data):
    points_in_radius = []
    for point in lab_data:
        latitude, longitude = point.latitude, point.longitude
        distance = haversine(center_lat, center_lon, latitude, longitude)
        if distance <= radius:
            points_in_radius.append(point)
    return points_in_radius
