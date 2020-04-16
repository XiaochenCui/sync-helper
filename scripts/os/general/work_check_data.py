#!/usr/bin/env python3

from utils.package_utils.validate import (
    ValidateError,
    validate_package,
)
from new_energy_obd.forward.deconstruct_package import deconstruct_package
from utils.time_utils import unix_timestamp
from datetime import datetime




def validate(data):
    data = data.decode('hex')
    try:
        package = deconstruct_package(data)
    except Exception:
        print 'Package length not validata: {}'.format(len(data))
        return

    print 'Payload length: {}'.format(package.length)
    print 'Payload actual length: {}'.format(len(package.payload))
    print 'Vin: {}'.format(package.unique_code)
    dt = package.payload[:6]
    timestamp = unix_timestamp(dt)
    print 'Timestamp: {}'.format(timestamp)
    print 'Datetime: {}'.format(datetime.fromtimestamp(int(timestamp)))
    try:
        validate_package(package)
    except ValidateError as e:
        print e


if __name__ == '__main__':
    import sys
    data = sys.argv[1]
    validate(data)
