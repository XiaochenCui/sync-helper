curl --socks5 127.0.0.1:1080 -LO https://storage.googleapis.com/kubernetes-release/release/`curl --socks5 127.0.0.1:1080 -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl

