FROM ubuntu:20.10

# https://developer.aliyun.com/article/704603
RUN sed -i -E 's/security.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
RUN sed -i -E 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list

RUN apt-get -y update

RUN apt-get -y install git
RUN cd ~ && rm -rf xiaochen-toolkit ; git clone --depth 1 https://github.com/XiaochenCui/xiaochen-toolkit.git && cd xiaochen-toolkit && ./setup/minimal.sh

# kafkacat
RUN apt-get -y install kafkacat

# ping
RUN apt-get -y install iputils-ping

# vim
RUN apt-get -y install vim