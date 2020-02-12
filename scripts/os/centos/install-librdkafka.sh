#!/bin/sh

cd $HOME
[[ -d "librdkafka" ]] && rm -r librdkafka
git clone https://github.com/edenhill/librdkafka.git
cd librdkafka
./configure --prefix /usr
make
make install
ldconfig