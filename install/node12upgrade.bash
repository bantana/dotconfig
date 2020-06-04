#!/usr/bin/env bash
if [[ "$(uname -s)" == "Linux" ]]; then
    echo ">>> Found Linux OS ..."
    # check ubuntu
    if [[ "$(lsb_release -is)" == "Ubuntu" ]]; then
        echo ">>> Found Ubuntu OS"
        sudo npm cache clean -f
        sudo npm install -g n
        sudo n stable
    fi
fi
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo ">>> Found Darwin OS ..."
    brew upgrade node@12

fi

