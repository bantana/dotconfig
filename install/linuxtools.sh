#!/usr/bin/env bash

if [[ $(uname -s) == "Linux" ]]; then
    sudo snap install ripgrep --classic
    sudo snap install shellcheck shfmt
    sudo apt install silversearcher-ag
    exit 0
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install shellcheck shfmt the_silver_searcher ripgrep
    exit 0
fi
