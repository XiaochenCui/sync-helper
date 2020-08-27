FROM ubuntu:20.10
RUN apt-get update
RUN apt-get -y install git
RUN cd ~ && rm -rf xiaochen-toolkit ; git clone --depth 1 https://github.com/XiaochenCui/xiaochen-toolkit.git && cd xiaochen-toolkit && ./setup/minimal.sh

RUN apt-get -y install kafkacat