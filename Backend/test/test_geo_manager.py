from other.models import Point
from managers.geo_manager import points_in_radius
import unittest


class TestPointInRadius(unittest.TestCase):
    def __init__(self, methodName='runTest'):
        super(TestPointInRadius, self).__init__(methodName)
        self.central_lat = 51.2324
        self.central_lon = 31.2312
        self.lab_data = [
            Point(id=1, name='lab1', latitude=51.2325, longitude=31.2312),
            Point(id=2, name='lab2', latitude=49.6244, longitude=22.2303),
            Point(id=3, name='lab3', latitude=48.9226, longitude=31.2367),
            Point(id=4, name='lab4', latitude=48.2914, longitude=21.2312),
            Point(id=5, name='lab5', latitude=51.2367, longitude=25.9352)
        ]

    def test_point_in_radius(self):
        test_cases = {
            0: [],
            10000: [self.lab_data[0], self.lab_data[1], self.lab_data[2], self.lab_data[3], self.lab_data[4]],
            300: [self.lab_data[0], self.lab_data[2]],
            256.9: [self.lab_data[0], self.lab_data[2]]
        }

        for radius, expected in test_cases.items():
            with self.subTest(radius=radius):
                result = points_in_radius(self.central_lat, self.central_lon, radius, self.lab_data)
                self.assertEqual(result, expected)
