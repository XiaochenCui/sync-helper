#!/bin/sh
files=$(git diff --name-only HEAD HEAD~ dockerfiles)
if [ -n "$files" ]; then
    echo "\nDockerfile changes detected:\n"
    echo "$files\n"
    docker-compose build
else
    echo "\nNo dockerfile changed\n"
fi
