from fastapi import APIRouter, Query, Depends
import json
from time import time
from Backend.managers.geo_manager import points_in_radius
from Backend.base.supa_client import supabase_client
from Backend.other.models import Point, User
from Backend.other.error import Error
from datetime import datetime, timezone
from Backend.managers.mailer_manager import get_current_user


error = Error()
router = APIRouter()


@router.post("/laboratories", tags=["laboratories"])
async def add_event(region: str = Query(..., description="Name of the region"),
                    center_lat: float = Query(..., description="Latitude of the center point"),
                    center_lon: float = Query(..., description="Longitude of the center point"),
                    radius: float = Query(..., description="Radius in kilometers"),
                    current_user: User = Depends(get_current_user)):
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

        if radius < 0:
            return Error.error_400("Radius cannot be negative")

        response = supabase_client.supabase.table("laboratory") \
            .select("id", "name", "latitude", "longitude") \
            .eq("region", region).execute()

        data = response.model_dump_json()
        lab_data = [Point(id=item["id"], name=item["name"], latitude=item["latitude"], longitude=item["longitude"]) for
                    item in json.loads(data)["data"]]

        result = points_in_radius(center_lat, center_lon, radius, lab_data)

        if not result:
            error.error_404("No laboratories found within the specified radius")
        print(time() - start, " worktime")
        return result
    except Exception as e:
        error.error_500(e, f"An error occurred while retrieving laboratories within radius: {e}")


@router.post("/create_visit", tags=["laboratories"])
async def create_user_visit(user_id: int = Query(..., description="User ID"),
                            status_id: int = Query(..., description="Status ID"),
                            timestamp: int = Query(..., description="Timestamp"),
                            facility_id: str = Query(..., description="Facility ID"),
                            current_user: User = Depends(get_current_user)):
    """
    Creates a user visit record with the provided information.

    Args:
        user_id (int): The ID of the user for whom the visit is being created.
        status_id (int): The ID of the status of the visit.
        timestamp (str): The timestamp of the visit.
        facility_id (str): The ID of the facility where the visit took place.

    Returns:
        dict: The response from the database after creating the user visit record.
    """
    try:
        timestamp = datetime.fromtimestamp(timestamp, tz=timezone.utc).strftime('%Y-%m-%d')
        response = supabase_client.supabase.table("user_visit").insert({
            "user_id": user_id,
            "status_id": status_id,
            "timestamp": timestamp,
            "facility_id": facility_id
        }).execute()
        return response
    except Exception as e:
        return error.error_500(e, f"An error occurred while trying to create a user_visit: {str(e)}")


@router.post("/user_visits", tags=["laboratories"])
async def user_visits(user_id: int = Query(..., description="User ID"),
                      current_user: User = Depends(get_current_user)):
    """
    Retrieves user visits from the database.

    Args:
        user_id (int): The ID of the user for whom to retrieve visits.

    Returns:
        dict: The response containing user visits.
            If no visits are found, returns a 404 error message.
    """
    try:
        response = supabase_client.supabase.table("user_visit").select("status_id", "timestamp", "facility_id").eq("user_id", user_id).execute()
        if response.data == []:
            error.error_404("No scheduled visit found")
        else:
            return response
    except Exception as e:
        return error.error_500(e, f"An error occurred while trying to retrieve data from the database: {str(e)}")
