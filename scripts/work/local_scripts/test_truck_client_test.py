# coding=utf-8
import logging


logger = logging.getLogger(__name__)


from rest_framework import status
from rest_framework.test import APITestCase


vin='A'*17
t = {"vin": vin}


class TruckTests(APITestCase):
    def test_create_truck(self):
        """
        Ensure we can create a new account object.
        """
        url = '/truck/truck/'
        response = self.client.put(url, t, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
