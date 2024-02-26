import datetime

from fastapi.testclient import TestClient
from Backend.app.routers.homepages import router
import unittest

client = TestClient(router)

class TestHomepages(unittest.TestCase):
    def test_burger(self):
        response = client.get("/burger?profile_id=1")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json(), {"username": "John Doe"})  

    '''def test_change_profile(self):
        response = client.post("/burger/change_profile?profile_id=1", data={"name": "New Name", "dob": "2000-01-01", "email": "new_email@example.com"})
        self.assertEqual(response.status_code, 200)
        expected_data = {
            "id": "1",
            "name": "New Name",
            "dob": '2000-01-01',  
            "email": "new_email@example.com"
        }
        response_data = response.json()
        response_data['dob'] = datetime.datetime.strptime(response_data['dob'], '%Y-%m-%d')
        self.assertDictEqual(response_data, expected_data)

'''

    def test_help(self):
        response = client.get("/burger/help?question=How to use this?")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json(), {"text": "Thank you, we will look into your question"})

