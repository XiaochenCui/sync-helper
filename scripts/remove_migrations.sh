#!/bin/sh
START=$1
for f in owl/migrations/*;
do
    filename=$(basename "$f")
    number=${filename%%_*}
    if [ -n "$number" ]
    then
        if [ $number -ge $START ]
        then
            echo "Remove: $f"
            rm $f
        fi
    fi
done
