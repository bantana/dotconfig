#!/usr/bin/env bash

if [[ $(uname -s) == "Linux" ]]; then
    sudo apt -y install clang-9 clang-tools-9 clang-9-doc clang-9-examples clang-format-9 clang libc6-dbg 
    sudo apt -y install valgrind ripgrep
    sudo apt-get install clangd-9
    sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100
    exit 0
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install llvm
    exit 0
fi
