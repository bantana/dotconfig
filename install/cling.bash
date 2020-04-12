#!/usr/bin/env bash
if [[ $(uname -s) == "Linux" ]]; then
    if [[ ! -d "$HOME/cling" ]]; then
        mkdir -p "$HOME/cling"
    fi


    curl -sL https://root.cern.ch/download/cling/cling_2020-04-02_ubuntu18.tar.bz2 |tar  -xj --one-top-level="$HOME/cling" --strip-components 1
    exit 0
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install cling
    exit 0
fi

