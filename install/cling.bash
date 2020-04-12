#!/usr/bin/env bash
if [[ $(uname -s) == "Linux" ]]; then
    if [[ ! -d "$HOME/cling" ]]; then
        mkdir -p "$HOME/cling"
    fi


    curl -sL https://root.cern.ch/download/cling/cling_2020-04-02_ubuntu18.tar.bz2 |tar  -xj --one-top-level="$HOME/cling" --strip-components 1

echo "\
The cling C++ interpreter
https://root.cern.ch/cling

To use cling, add the following line to your .profile:
if [ -d "\$HOME/cling/bin" ] ; then
    PATH="\$PATH:\$HOME/cling/bin"
fi
"
    exit 0
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install cling
    exit 0
fi

