#!/usr/bin/env bash
set -euo pipefail

if [[ $(uname -s) == "Linux" ]]; then
    echo "install mundo vim plugin support ..."
    sudo apt -y install python3-pip
    nvim +UpdateRemotePlugins +qall
fi
