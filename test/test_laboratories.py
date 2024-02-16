import sys
sys.path.append('/Users/yanakravets/HealthFlow/Backend')
from laboratories import points_in_radius, Point
import unittest

class TestPointInRadius(unittest.TestCase):
    def setUp(self):
        self.central_lat = 51.2324
        self.central_lon = 31.2312
        self.lab_data = [
            Point(id=1, name = 'lab1', latitude = 51.2325, longitude = 31.2312),
            Point(id=2, name = 'lab2', latitude = 49.6244, longitude = 22.2303),
            Point(id=3, name = 'lab3', latitude = 48.9226, longitude = 31.2367),
            Point(id=4, name = 'lab4', latitude = 48.2914, longitude = 21.2312),
            Point(id=5, name = 'lab5', latitude = 51.2367, longitude = 25.9352)
        ]

    def test_no_points_in_radius(self):
        radius = 0
        result = points_in_radius(self.central_lat, self.central_lon, radius, self.lab_data)
        self.assertEqual(result, [])
    
    def test_radius_negative(self):
        radius = -25
        with self.assertRaises(ValueError):
            points_in_radius(self.central_lat, self.central_lon, radius, self.lab_data)

    def test_all_points_in_radius(self):
        radius = 10000
        result = points_in_radius(self.central_lat, self.central_lon, radius, self.lab_data)  
        expected_res = [self.lab_data[0],self.lab_data[1],self.lab_data[2],self.lab_data[3],self.lab_data[4]]      
        self.assertEqual(result,expected_res)

    def test_some_points_in_radius(self):
       radius = 300
       result = points_in_radius(self.central_lat, self.central_lon, radius, self.lab_data)  
       expected_res = [self.lab_data[0], self.lab_data[2]]   
       self.assertEqual(result, expected_res)

    def test_point_in_another_on_border(self):
        radius = 256.9 
        result = points_in_radius(self.central_lat, self.central_lon, radius, self.lab_data)  
        expected_res = [self.lab_data[0], self.lab_data[2]]   
        self.assertEqual(result, expected_res)   





