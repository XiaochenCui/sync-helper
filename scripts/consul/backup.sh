#!/bin/sh

DATE=`date +%Y%m%d%H%M`

export CONSUL_HTTP_ADDR=192.168.3.21:28501
export CONSUL_HTTP_TOKEN=9f012e18-1a62-4a0a-4d8e-f6ef9f45c689

consul kv export > kv.dump.$DATE
consul snapshot save backup.snap.$DATE