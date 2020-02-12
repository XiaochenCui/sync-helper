#!/bin/sh
printf "Checking migrations integrity ...\n"
root="$(git rev-parse --show-toplevel)"
count="$(find ${root}/owl/migrations -name '0*.py' | wc -l)"
for i in `seq -w 1 $count`
do
    leading_zeros=`expr 4 - ${#i}`
    file_prefix=$i
    for j in `seq $leading_zeros`
    do
        file_prefix="0$file_prefix"
    done
    match_count="$(find ${root}/owl/migrations -name $file_prefix*py | wc -l)"
    if [ $match_count -gt 1 ]
    then
        printf "Migration $i is more than 1\n"
        exit 1
    elif [ $match_count -eq 0 ]
    then
        printf "Migration $i does not exist\n"
        exit 2
    fi
done
printf "Done\n"
