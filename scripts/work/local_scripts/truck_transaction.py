# coding=utf-8
import logging


logger = logging.getLogger(__name__)


from owl.models import Truck
from django.db import transaction

vin='A'*17

with transaction.atomic():
    logger.debug("transaction start...")
    Truck.objects.create(vin=vin)
    import time
    import sys
    time.sleep(int(sys.argv[1]))
    logger.debug("transaction end...")
