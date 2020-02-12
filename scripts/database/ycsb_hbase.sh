#!/usr/bin/env bash
set -x
#
# Simulates mixed workload on HBase using YCSB
# Author: Ashrith (ashrith at cloudwick dot com)
# Date: Wed, 16 2014
#

#
# You may want to tweak these variables to change the workload's behavior
#
# Number of total rows to insert into hbase
RECORDS_TO_INSERT=100000
# Total operations to perform for a specified workload
TOTAL_OPERATIONS_PER_WORKLOAD=10000
# Throttling (specifies number of operations to perform per sec by ycsb)
OPERATIONS_PER_SEC=1000
# Number of threads to use in each workload
THREADS=5
# Name of the hbase column family
HBASE_CFM="f1"
# Number of hbase regions to create initially while creating the table in hbase
HBASE_RC=16
# Log file to use
LOG="/tmp/hbase_ycsb.log"

#
# NOTE: DON'T CHANGE BEYOND THIS POINT SCRIPT MAY BREAK
#

# Create a table with specfied regions and with one column family
echo "Creating pre-splitted table"
echo "create 'usertable', '${HBASE_CFM}'" | hbase shell >> $LOG
hbase org.apache.hadoop.hbase.util.RegionSplitter usertable HexStringSplit \
  -c ${HBASE_RC} -f ${HBASE_CFM} >> $LOG

# Load the dataset (no throttling)
echo "Loading intial dataset"
bin/ycsb load hbase10 -P workloads/workloada -p columnfamily=${HBASE_CFM} \
  -p recordcount=${RECORDS_TO_INSERT} \
  -s -threads ${THREADS} >> /tmp/hbase_load.log

#
# => Workload simulation (Throtlling 10000 operations/second)
#
echo "Simulating workloads"
# Update heavy workload Read/Update ratio: 50/50.
bin/ycsb run hbase10 -P workloads/workloada -p columnfamily=${HBASE_CFM} \
  -p operationcount=${TOTAL_OPERATIONS_PER_WORKLOAD} \
  -target ${OPERATIONS_PER_SEC} \
  -threads ${THREADS} -s >> /tmp/workloada.log
# Read mostly workload Read/Update ratio: 95/5
bin/ycsb run hbase10 -P workloads/workloadb -p columnfamily=${HBASE_CFM} \
  -p operationcount=${TOTAL_OPERATIONS_PER_WORKLOAD} \
  -target ${OPERATIONS_PER_SEC} \
  -threads ${THREADS} -s >> /tmp/workloadb.log
# Read Only workload Read/Update ratio: 100/0
bin/ycsb run hbase10 -P workloads/workloadc -p columnfamily=${HBASE_CFM} \
  -p operationcount=${TOTAL_OPERATIONS_PER_WORKLOAD} \
  -target ${OPERATIONS_PER_SEC} \
  -threads ${THREADS} -s >> /tmp/workloadb.log
# Read Modify Write workload Read/Update ratio: 50/50
bin/ycsb run hbase10 -P workloads/workloadf -p columnfamily=${HBASE_CFM} \
  -p operationcount=${TOTAL_OPERATIONS_PER_WORKLOAD} \
  -target ${OPERATIONS_PER_SEC} \
  -threads ${THREADS} -s >> /tmp/workloadb.log
# Read latest workload Read/Update/Insert ration: 95/0/5
bin/ycsb run hbase10 -P workloads/workloadd -p columnfamily=${HBASE_CFM} \
  -p operationcount=${TOTAL_OPERATIONS_PER_WORKLOAD} \
  -target ${OPERATIONS_PER_SEC} \
  -threads ${THREADS} -s >> /tmp/workloadb.log
# Short ranges workload Scan/insert ratio: 95/5
bin/ycsb run hbase10 -P workloads/workloade -p columnfamily=${HBASE_CFM} \
  -p operationcount=${TOTAL_OPERATIONS_PER_WORKLOAD} \
  -target ${OPERATIONS_PER_SEC} \
  -threads ${THREADS} -s >> /tmp/workloadb.log

# Count rows in a table
# echo "count 'usertable'" | hbase shell

# Delete the table contents
# echo "truncate 'usertable'" | hbase shell

# Disable and Drop table existing
echo "Disabling and dropping table"
echo "disable 'usertable'" | hbase shell >> $LOG
echo "drop 'usertable'" | hbase shell >> $LOG
