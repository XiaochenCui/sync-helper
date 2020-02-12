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