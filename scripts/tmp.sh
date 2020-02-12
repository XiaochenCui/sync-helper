kill_by_name() {
    ps aux | grep "$1" | awk '{print $2}' | xargs -n 1 kill
}


# pip install requirements file line by line in a seprate way
pip_install() {
    if [[ -n "$1" ]]; then
        echo $1
        cat "$1" | xargs -n 1 pip install
    else
        echo "Must specify a requirements file"
    fi
}
