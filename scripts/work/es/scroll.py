from elasticsearch import Elasticsearch
import json
import time

# Define config
host = "10.168.0.225"
port = 9200
timeout = 1000
index = "pro4new2gateway-2020.03.09"
doc_type = "doc"
size = 1000
body = {
  "query": {
    "simple_query_string" : {
        "query": "msg check",
        # "fields": ["message"],
        # "default_operator": "and"
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
def process_hits(hits):
    for item in hits:
        msg = item["_source"]["message"]
        # print(json.dumps(item, indent=2))


# Check index exists
if not es.indices.exists(index=index):
    print("Index " + index + " not exists")
    exit()

# Init scroll by search
data = es.search(
    index=index,
    doc_type=doc_type,
    scroll='2m',
    size=size,
    body=body
)
print(data)

# Get the scroll ID
sid = data['_scroll_id']
scroll_size = len(data['hits']['hits'])

if scroll_size > 0:
    "Scrolling..."
    
    # Before scroll, process current batch of hits
    process_hits(data['hits']['hits'])
    
    data = es.scroll(scroll_id=sid, scroll='2m')

    # Update the scroll ID
    sid = data['_scroll_id']

    # Get the number of results that returned in the last scroll
    scroll_size = len(data['hits']['hits'])