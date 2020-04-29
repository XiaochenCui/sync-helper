command=$1
origin_location=$(which $command)

echo "源地址为：$origin_location"

# 查看指令是否存在
if [[ "$origin_location" == "" ]]; then
    echo "command '$command' not found, exit"
    exit 1
fi

# 查看指令是否是 symbolink
if [[ -L "$origin_location" ]]; then
    echo "command '$command' is symbolink, exit"
    exit 1
fi

backup_location="$origin_location.bak"
echo "备份地址为：$backup_location"

# 备份
cp $origin_location $backup_location
rm $origin_location