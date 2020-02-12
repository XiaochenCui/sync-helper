# coding=utf-8
import logging

import time
from datetime import datetime

import struct


def bytes_to_int(byte, byte_order='>'):
    """
    :type byte: str
    :type byte_order: str
    """
    if len(byte) == 1:
        format_flag = 'B'
    elif len(byte) == 2:
        format_flag = 'H'
    elif len(byte) == 4:
        format_flag = 'L'

    format_string = byte_order + format_flag

    return struct.unpack(format_string, byte)[0]


def int_to_bytes(integer, bytes_size=4, byte_order='>'):
    """
    :type byte: str
    :type byte_order: str
    """
    if bytes_size == 1:
        format_flag = 'B'
    elif bytes_size == 2:
        format_flag = 'H'
    elif bytes_size == 4:
        format_flag = 'L'

    format_string = byte_order + format_flag

    return struct.pack(format_string, integer)

def unix_timestamp(time_field):
    """
    Deconstruct time field in package, return unix timestamp in int

    :type time_field: str
    :rtype: int
    """
    print time_field
    year = 2000 + bytes_to_int(time_field[0])
    month = bytes_to_int(time_field[1])
    day = bytes_to_int(time_field[2])
    hour = bytes_to_int(time_field[3])
    minute = bytes_to_int(time_field[4])
    second = bytes_to_int(time_field[5])

    print month

    dt = datetime(year, month, day, hour, minute, second)
    return int(time.mktime(dt.timetuple()))


import sys


timestamp = unix_timestamp(sys.argv[1].decode('hex'))
print 'Timestamp: {}'.format(timestamp)
print 'Datetime: {}'.format(datetime.fromtimestamp(int(timestamp)))
