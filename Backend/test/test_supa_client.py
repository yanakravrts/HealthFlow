from base.supa_client import Settings, SupabaseDBClient
from unittest.mock import patch, MagicMock
from supabase._sync.client import SupabaseException
import unittest


class TestSupabaseDBClient(unittest.TestCase):
    @patch('Backend.base.supa_client.create_client')
    def test_connect_success(self, mock_create_client):
        mock_create_client.return_value = MagicMock()
        settings = Settings(SUPABASE_URL='mock_url', SUPABASE_KEY='mock_key')
        supabase_client = SupabaseDBClient(settings)
        connection_result = supabase_client.connect()
        self.assertFalse(connection_result.has_error)
        self.assertEqual(connection_result.notification, "Connected successfully")
        self.assertEqual(connection_result.status, 200)

    @patch('Backend.base.supa_client.create_client')
    def test_connect_failure(self, mock_create_client):
        mock_create_client.side_effect = SupabaseException("Connection failed")
        settings = Settings(SUPABASE_URL='mock_url', SUPABASE_KEY='mock_key')
        supabase_client = SupabaseDBClient(settings)
        connection_result = supabase_client.connect()
        self.assertTrue(connection_result.has_error)
        self.assertEqual(connection_result.notification, "Failed to connect to Supabase: Connection failed")
        self.assertEqual(connection_result.status, 500)
