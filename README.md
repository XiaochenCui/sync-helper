# Xiaochen Cui's toolkit

[![Build Status](https://travis-ci.org/XiaochenCui/xiaochen-toolkit.svg?branch=master)](https://travis-ci.org/XiaochenCui/xiaochen-toolkit)

## Install

### Install on private computer(zsh installed, github private key exists)

`cd ~ && git clone git@github.com:XiaochenCui/xiaochen-toolkit.git && cd xiaochen-toolkit && make install`

### Install on public server(bash installed, without github private key)

`cd ~ && rm -rf xiaochen-toolkit ; git clone --depth 1 https://github.com/XiaochenCui/xiaochen-toolkit.git && cd xiaochen-toolkit && ./setup/minimal.sh`

## Sync Helper

### Features

- Support macOS & Linux
- Include list & Exclude list
- Provide lots of useful scirpts

### Synchronize between local and remote

1. Add name of configurations files which you want to synchronize to include.txt

1. `sync-helper`

### Comming Soon

- Backup before synchronize to local
- Encryption for sensitive information
- Use copy instead of symbol link

## Welcome contributors

This project is still under development, welcome to submit pull request.
