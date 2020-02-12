#!/bin/sh

FILENAME_LIST="config-files-list.txt"

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "--------"
    source=~/"$line"
    dest_dir="./config_files/"
    echo "$dest_dir$line"
    if [[ -e $dest_dir$line ]]; then
        echo "File aleady exist, skip"
    else
        echo "$source"
        echo "$dest_dir"
        cp -r "$source" "$dest_dir"
        if [ "$?" -eq "0" ]; then
            echo "Success sync file/directory $line to current workspace"
        else
            echo "Copy operation failed"
            exit 1
        fi
    fi
done < "$FILENAME_LIST"
