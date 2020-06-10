source "printf.sh"

DIR=$HOME/xiaochen-toolkit
FILE=$DIR/last-sync.tmp

if [[ -ne $FILE ]]; then
    print_green "auto sync"
fi