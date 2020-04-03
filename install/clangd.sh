#!/usr/bin/env bash

if [[ $(uname -s) == "Linux" ]]; then
    if [[ $(lsb_release -cs) == "eoan" ]]; then
        sudo apt -y install clang-9 clang-tools-9 clang-9-doc clang-9-examples clang-format-9 clang libc6-dbg clang-tidy
        sudo apt -y install valgrind
        sudo apt-get install clangd-9
        sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100
    fi
    if [[ $(lsb_release -cs) == "focal" ]]; then
        sudo apt -y install clang-10 clang-tools-10 clang-10-doc clang-10-examples clang-format-10 clang libc6-dbg clang-tidy
        sudo apt -y install valgrind
        sudo apt-get install clangd-10
        sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100
    fi
    exit 0
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install llvm
    exit 0
fi
