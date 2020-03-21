#!/usr/bin/env bash

err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

success() {
    echo ">>> SUCCESS: $1 $2 installed!"
}

gover="1.14"
ostypes="$(uname -s)"

function InstallGo() {
    echo ">>> Found $ostypes} OS ..."
    if [[ ! -d ~/sdk ]]; then
        mkdir -p ~/sdk
    fi
    if [[ -d ~/sdk/go ]]; then
	if [[ $(go version |awk '{print $3}'|awk -F "o" '{print $2}') == "$gover" ]]; then
		echo "go version $gover already"
		exit 0
	fi
        echo ">>> WARRING: found old ~/sdk/go directory! remove ..."
        rm -rf "$HOME/sdk/go"
        if [[ $? -ne 0 ]]; then
            err "removing old directory ~/sdk/go failed!"
            exit 1
        fi
        echo ">>> removed old directory ~/sdk/go success!"
    fi
    # get golang for linux
    # TODO: check ~/sdk/go and clean
    curl -s https://dl.google.com/go/go"${gover}.${ostypes,}"-amd64.tar.gz | tar xzv -C ~/sdk/
    if [[ $? -ne 0 ]]; then
        err "golang install failed!"
        exit 1
    fi
    success Golang ${gover}
    exit 0
    unset ostypes
    unset gover

}

InstallGo
