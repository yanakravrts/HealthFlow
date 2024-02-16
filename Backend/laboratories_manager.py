import math
from error import Error

error = Error()

def haversine(lat1, lon1, lat2, lon2):
    """
    This function calculates the distance between two points on the Earth's surface using the Haversine formula.

    Arguments:
    lat1: Latitude of the first point in degrees.
    lon1: Longitude of the first point in degrees.
    lat2: Latitude of the second point in degrees.
    lon2: Longitude of the second point in degrees.

    Returns:
    distance: Distance between the two points in kilometers.
    """
    R = 6371
    lat1, lon1, lat2, lon2 = map(math.radians, [lat1, lon1, lat2, lon2])
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
    distance = 2 * R * math.asin(math.sqrt(a))
    return distance


def points_in_radius(center_lat, center_lon, radius, lab_data):
    """
    Determines the list of points within a specified radius from the given center point.

    Arguments:
    - center_lat: Latitude of the center point in degrees.
    - center_lon: Longitude of the center point in degrees.
    - radius: Radius in kilometers.
    - lab_data: List of points (laboratories) to check for proximity.

    Returns:
    - List of points (laboratories) within the specified radius from the center point.
    """
    if radius < 0:
        return Error.error_400(f"Radius cannot be negative")

    # if radius < 0:
    # raise ValueError("Radius cannot be negative")

    points_in_radius = []
    for point in lab_data:
        latitude, longitude = point.latitude, point.longitude
        distance = haversine(center_lat, center_lon, latitude, longitude)
        if distance <= radius:
            points_in_radius.append(point)
    return points_in_radius
