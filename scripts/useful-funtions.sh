#!/bin/sh

# import libs
source "os.sh"

echo "Your operation system is: $OS"

set_develop_host() {
    case $OS in
        macOS)
            sudo
            j
