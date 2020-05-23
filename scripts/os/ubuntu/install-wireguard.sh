#!/bin/bash
set +ex

# install wireguard on ubuntu18.04

# sudo apt-get install linux-headers-4.15.0-99-generic
sudo add-apt-repository ppa:wireguard/wireguard
sudo apt-get update
sudo apt-get install wireguard