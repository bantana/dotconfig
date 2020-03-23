#!/usr/bin/env bash

if [[ $(uname -s) == "Linux" ]]; then
sudo snap install shellcheck shfmt
sudo apt install silversearcher-ag
    exit 0
fi
if [[ $(uname -s) == "Darwin" ]]; then
    # todo
    exit 0
fi
