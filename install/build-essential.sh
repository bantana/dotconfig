#!/usr/bin/env bash

if [[ $(uname -s)  == "Linux" ]]; then
    sudo apt -y install build-essential ack
fi
if [[ $(uname -s) == "Darwin" ]]; then
    xcode-select --install
fi
