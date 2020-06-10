#!/bin/zsh

# import libs
source "_printf.sh"
source "os.sh"

case $OS in
    ubuntu)
        sudo apt-get install -y python-software-properties
        sudo add-apt-repository ppa:keithw/mosh
        sudo apt-get update -y
        sudo apt-get install -y mosh
        ;;
    centos)
        sudo yum install -y mosh
        ;;
    *)
        printf_red "Not support your system($OS) for now"
        exit 2
        ;;
esac
