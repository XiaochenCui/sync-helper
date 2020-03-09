from elasticsearch import Elasticsearch
import json
import time

import xlrd
truck_file = "missing_trucks.xls"
book = xlrd.open_workbook(truck_file)
sh = book.sheet_by_index(0)
vins = list()
for rx in range(sh.nrows):
    value = sh.row(rx)[0].value
    if len(value) == 17:
        vins.append(value)
print("truck count: {}".format(len(vins)))

# Define config
host = "10.168.0.225"
port = 9200
timeout = 1000
index = "pro4new2gateway-2020.03.0*"
doc_type = "doc"
size = 10000
body = {
    "query": {
        "bool": {
            "must": {
                "simple_query_string": {
                    "query": "msg check",
                    "default_operator": "AND"
                }
            },
            "filter": {
                "range": {
                    "@timestamp": {
                        "gte": "2020-03-05T21:00:00",
                        "lte": "2020-03-06T17:00:00",
                        "time_zone": "+08:00"
                    }
                }
            }
        }
    }
}

# Init Elasticsearch instance
es = Elasticsearch(
    [
        {
            'host': host,
            'port': port
        }
    ],
    timeout=timeout
)


# Process hits here
class Counter(object):
    def __init__(self):
        self.i = 0
        self.hit_vins = set()

        self.package_in_vin = 0

    def process_hits(self, hits):
        for item in hits:
            msg = item["_source"]["message"]
            vin = msg[104:104+17]
            if vin in vins:
                self.package_in_vin += 1
            self.hit_vins.add(vin)
        self.i += len(hits)
        print('current count : {}'.format(self.i))


# Check index exists
if not es.indices.exists(index=index):
    print("Index " + index + " not exists")
    exit()

# Init scroll by search
data = es.search(
    index=index,
    doc_type=doc_type,
    scroll='120m',
    size=size,
    body=body
)

# Get the scroll ID
sid = data['_scroll_id']
scroll_size = len(data['hits']['hits'])

c = Counter()

while scroll_size > 0:
    "Scrolling..."

    # Before scroll, process current batch of hits
    c.process_hits(data['hits']['hits'])

    data = es.scroll(scroll_id=sid, scroll='2m')

    # Update the scroll ID
    sid = data['_scroll_id']

    # Get the number of results that returned in the last scroll
    scroll_size = len(data['hits']['hits'])

print('total package: {}'.format(c.i))

print('vins: {}'.format(len(vins)))
print('hit vins: {}'.format(len(c.hit_vins)))

diff_vins = [i for i in vins if i not in c.hit_vins]
print('diff vins: {}'.format(len(diff_vins)))