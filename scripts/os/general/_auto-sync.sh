source "_printf.sh"

DIR=$HOME/xiaochen-toolkit
FILE=$DIR/last-sync.tmp
today=`date +%Y%m%d`

sync() {
    # 先写入文件，防止无限循环
    echo $today > $FILE

    sync-helper
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