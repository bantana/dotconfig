#!/usr/bin/env bash

if [[ $(uname -s) == "Linux" ]]; then
    sudo snap install ccls --classic
    sudo apt -y install clang-9 clang-tools-9 clang-9-doc clang-9-examples clang-format-9 clang
    exit 0
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install ccls
    exit 0
fi
