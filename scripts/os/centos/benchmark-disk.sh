clear() {
    echo 3 | sudo tee /proc/sys/vm/drop_caches
}

dd if=/dev/zero of=/tmp/temp.bin bs=1G count=10 oflag=direct
