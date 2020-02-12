# coding=utf-8
import logging


logger = logging.getLogger(__name__)


import requests


TIMEOUT=10


if __name__ == "__main__":
    import sys
    host = sys.argv[1]
    auth = {
        "username": "18627178938",
        "password": "18627178938",
    }
    auth_url = "http://{}/auth/token/profile/get/".format(host)
    print "Read to send request to {}...".format(auth_url)
    r = requests.post(auth_url, data=auth, timeout=TIMEOUT)
    print r.status_code
    print r.text
    print r.json()

    headers = {
        "Authorization": "JWT {}".format(r.json()[u"token"])
    }

    report_url = "http://{}/monitor/hbase_alert_record/".format(host)
    print "Read to send request to {}...".format(report_url)
    r = requests.get(report_url, headers=headers, timeout=TIMEOUT)
    print r.status_code
    print r.text
    print r.json()
