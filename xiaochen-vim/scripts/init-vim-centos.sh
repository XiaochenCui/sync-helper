#!/usr/bin/env bash

# for ycm
yum install -y gcc gcc-c++ kernel-devel cmake golang ncurses-devel

sudo yum -y remove vim

cd ~ && rm -rf vim && git clone git@github.com:vim/vim.git && cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib64/python2.7/config \
            --enable-luainterp=yes \
            --enable-cscope \
            --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
sudo make install
