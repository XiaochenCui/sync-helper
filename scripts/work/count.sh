#!/bin/sh
YEAR=2019
MONTH=03
for DAY in 28; do
    echo "Statistics infomation of ${DAY}:"
    send_count=0
    reply_count=0
    for time in {00..23}; do
      send="$(grep -c -E "${YEAR}-${MONTH}-${DAY} ${time}.*raw_send" haibo.log)"
      receive="$(grep -c -E "${YEAR}-${MONTH}-${DAY} ${time}.*raw_receive" haibo.log)"
      echo "Send ${send} packages in ${YEAR}-${MONTH}-${DAY} ${time}"
      echo "Receive ${receive} success reply"
      send_count=$(( send_count + send ))
      reply_count=$(( reply_count + receive))
    done
    echo "Total send: $send_count"
    echo "Total reply: $reply_count"
done
for DAY in 28; do
    echo "Statistics infomation of ${DAY}:"
    send_count=0
    reply_count=0
    for time in {00..23}; do
      sync="$(grep -c -E "${YEAR}-${MONTH}-${DAY} ${time}.*Sync" haibo.log)"
      send="$(grep -c -E "${YEAR}-${MONTH}-${DAY} ${time}.*Data to send" haibo.log)"
      success="$(grep -c -E "${YEAR}-${MONTH}-${DAY} ${time}.*success" haibo.log)"
      failed="$(grep -c -E "${YEAR}-${MONTH}-${DAY} ${time}.*Failed" haibo.log)"
      success=$(( success - sync))
      echo "Send ${send} packages in ${YEAR}-${MONTH}-${DAY} ${time}"
      echo "Receive ${success} success reply"
      echo "Receive ${failed} failure reply"
      send_count=$(( send_count + send ))
      reply_count=$(( reply_count + success + failed ))
    done
    echo "Total send: $send_count"
    echo "Total reply: $reply_count"
done
