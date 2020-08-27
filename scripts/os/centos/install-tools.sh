#!/bin/bash

yum install -y epel-release
yum install -y nethogs
yum install -y iperf3
yum install -y gcc gcc-c++
yum install -y bridge-utils
yum install -y bind-utils

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc

# k8s tools
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
mv /usr/local/bin/kubectx /usr/local/bin/kubectl-ctx
mv /usr/local/bin/kubens /usr/local/bin/kubectl-ns

# install hstr
yum install -y automake autoconf
yum install -y ncurses-devel
yum install -y readline-devel
git clone --depth 1 --branch 2.2 https://github.com/dvorka/hstr.git
cd hstr
cd ./build/tarball && ./tarball-automake.sh && cd ../..
./configure && make && make install