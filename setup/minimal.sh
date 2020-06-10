#!/bin/bash

export PATH=$PATH:~/xiaochen-toolkit/scripts/os/general

source "_printf.sh"
source "os.sh"

create() {
    binary="$HOME/bin"
    [[ -d "$binary" ]] || mkdir "$binary"

    local_config="$HOME/.localrc"
    [[ -f "$local_config" ]] || touch "$local_config"
}

create

grep -F ".minrc" ~/.bashrc 1>/dev/null || printf "\nsource ~/.minrc\n" >> ~/.bashrc

ln -sf "$PWD"/minrc ~/.minrc

./sync-min

printf_green "Done"
