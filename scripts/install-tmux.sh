#!/bin/zsh

# import libs
source "printf.sh"
source "os.sh"

echo "Your operation system is: $OS"

case $OS in
    ubuntu)
        sudo apt-get install -y tmux
        ;;
    centos)
        sudo yum install -y tmux
        ;;
    *)
        printf_red "Not support your system($OS) for now"
        exit 2
        ;;
esac
