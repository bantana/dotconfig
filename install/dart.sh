#!/usr/bin/env bash

if [[ "$(uname -s)" == "Linux" ]]; then
    echo ">>> Found Linux OS ..."
    # check ubuntu
    if [[ "$(lsb_release -is)" == "Ubuntu" ]]; then
        echo ">>> Found Ubuntu OS"

        if [[ ! -f "/etc/apt/sources.list.d/dart_stable.list" ]]; then
            sudo apt-get -y update
            sudo apt-get -y install apt-transport-https
            curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sudo curl -sL https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list -o /etc/apt/sources.list.d/dart_stable.list
        fi
        sudo apt-get  -y update
        sudo apt-get -y install dart
        source $HOME/.profile
    fi
fi
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo ">>> Found Darwin OS ..."
    brew tap dart-lang/dart
    brew install dart
    source $HOME/.bash_profile
fi

hash
pub global activate dart_language_server
pub global activate dart_style
pub global activate stagehand
