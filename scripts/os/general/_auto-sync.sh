source "_printf.sh"

DIR=$HOME/xiaochen-toolkit
FILE=$DIR/last-sync.tmp
today=`date +%Y%m%d`

sync() {
    echo $today > $FILE
    sync-helper -v
}

if [[ ! -e $FILE ]]; then
    sync
    exit
fi

origin=`cat $FILE`
if [[ $origin != $today ]]; then
    sync
    exit
fi