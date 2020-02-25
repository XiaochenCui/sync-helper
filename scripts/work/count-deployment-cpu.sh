#!/bin/bash
for i in {1..12}
do
    cpu=$(kubectl top pod | grep $1 | awk '{ SUM += $2} END {print SUM}')
    memory=$(kubectl top pod | grep $1 | awk '{ SUM += $3} END {print SUM}')
    printf "cpu: $cpu\t\tmemory: $memory\n"
    sleep 10
done