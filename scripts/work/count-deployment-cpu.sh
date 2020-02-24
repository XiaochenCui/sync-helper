for i in {1..12}
do
    k top pod | grep $1 | awk '{ SUM += $2} END {print SUM}'
done