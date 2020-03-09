from elasticsearch import Elasticsearch

from elasticsearch import Elasticsearch
es = Elasticsearch(["10.168.0.225:9200","10.168.0.226:9200"])
es.get(index="pro4forward2nation-2020.03.09", id="1tApv3ABGHROwHLvXVNc", doc_type="_all")['_source']['message']
es.mget(index="pro4forward2nation-2020.03.09", doc_type="_all")
es.index("my-index", 42, body={"any": "data", "timestamp": datetime.now()})

es = Elasticsearch(["10.168.0.225:9200","10.168.0.226:9200"])

import elasticsearch
import elasticsearch.helpers
es = elasticsearch.Elasticsearch()
results = elasticsearch.helpers.scan(es,
    index="pro4forward2nation-2020.03.09",
    doc_type="_all",
    preserve_order=True,
    # query={"query": {"match_all": {}}},
    query=None,
)

for item in results:
    print(item['_id'], item['_source']['name'])


es = Elasticsearch(['http://yourElasticIP:9200/'])
doc = {
        'size' : 10000,
        'query': {
            'match_all' : {}
       }
   }
res = es.search(index='pro4forward2nation-2020.03.09', doc_type='_all', body=doc,scroll='1m')

scrollId = res['_scroll_id']
es.scroll(scroll_id = scrollId, scroll = '1m')