source "printf.sh"

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$ID
    VER=$VERSION_ID
else
    # maybe it is macOS
    uname=$(uname)
    if [[ "$uname" == "Darwin" ]]; then
        OS="macOS"
    fi
fi

printf_green "Your operation system is ${OS}\n"
