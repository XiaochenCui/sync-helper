#!/bin/bash

export PATH=$PATH:~/xiaochen-toolkit/scripts/os/general

source "_printf.sh"
source "os.sh"

if [ ${SHELL##*/} = "zsh" ]
then
    ln -sf $HOME/xiaochen-toolkit/sync-helper /usr/local/bin
else
    ln -sf $HOME/xiaochen-toolkit/sync-min /usr/local/bin
fi
