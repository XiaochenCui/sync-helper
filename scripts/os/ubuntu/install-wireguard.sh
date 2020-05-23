#!/bin/bash
# install wireguard on ubuntu18.04

set +ex

sudo add-apt-repository -y ppa:wireguard/wireguard
sudo apt -y update
sudo apt -y install wireguard
sudo apt -y install resolvconf