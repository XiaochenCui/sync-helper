from elasticsearch import Elasticsearch
import json
import time

# Define config
host = "10.168.0.225"
port = 9200
timeout = 1000
index = "pro4new2gateway-2020.03.09"
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
                        "gte": "2020-03-08T00:00:00",
                        "lt": "2020-03-08T01:00:00",
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

    def process_hits(self, hits):
        for item in hits:
            msg = item["_source"]["message"]
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
    scroll='60m',
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

print('total: {}'.format(c.i))