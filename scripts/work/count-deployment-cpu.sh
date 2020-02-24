#!/bin/bash
for i in {1..12}
do
    kubectl top pod | grep $1 | awk '{ SUM += $2} END {print SUM}'
done