#!/usr/bin/env bash

if [[ $(uname -s) == "Linux" ]]; then
    if [[ $(lsb_release -cs) == "bionic" ]]; then
        sudo snap install ripgrep --classic
        sudo snap install shellcheck shfmt
        sudo apt install silversearcher-ag
        exit 0
    fi
        if [[ $(lsb_release -cs) == "eoan" ]]; then
        sudo snap install ripgrep --classic
        sudo snap install shellcheck shfmt
        sudo apt install silversearcher-ag
        exit 0
    fi
    if [[ $(lsb_release -cs) == "focal" ]]; then
        sudo snap install shfmt
        sudo apt install shellcheck silversearcher-ag ripgrep
        exit 0
    fi
    if [[ $(uname -s) == "Darwin" ]]; then
        brew install shellcheck shfmt the_silver_searcher ripgrep
        exit 0
    fi
fi
