# coding=utf-8
import logging


logger = logging.getLogger(__name__)


from owl.models import Truck
from django.db import transaction
from rest_framework.parsers import JSONParser

vin='A'*17

import io
import json

t = {"vin": vin}

from owl.apps.truck.serializers import TruckSerializer

stream = io.BytesIO(json.dumps(t))
data = JSONParser().parse(stream)

logger.debug(data)
serializer = TruckSerializer(data=data)

with transaction.atomic():
    logger.debug(serializer.is_valid())
    logger.debug(serializer.save())
    logger.debug(Truck.objects.filter(vin=vin))

    import time
    time.sleep(3)
    logger.debug(Truck.objects.filter(vin=vin).delete())
