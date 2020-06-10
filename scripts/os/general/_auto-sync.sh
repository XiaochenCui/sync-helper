source "_printf.sh"

DIR=$HOME/xiaochen-toolkit
FILE=$DIR/last-sync.tmp

if [[ -ne $FILE ]]; then
    printf_green "auto sync"
fi