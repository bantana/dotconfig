#!/usr/bin/env bash

err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

success() {
    echo ">>> SUCCESS: $1 $2 installed!"
}

GOVER="1.14"
OSTYPE="$(uname -s)"

function InstallGo() {
    echo ">>> Found ${OSTYPE} OS ..."
    if [[ ! -d ~/sdk ]]; then
        mkdir -p ~/sdk
    fi
    if [[ -d ~/sdk/go ]]; then
	if [[ $(go version |awk '{print $3}'|awk -F "o" '{print $2}') == "$GOVER" ]]; then
		echo "go version $GOVER already"
		exit 0
	fi
        echo ">>> WARRING: found old ~/sdk/go directory! remove ..."
        rm -rf "~/sdk/go"
        if [[ $? -ne 0 ]]; then
            err "removing old directory ~/sdk/go failed!"
            exit 1
        fi
        echo ">>> removed old directory ~/sdk/go success!"
    fi
    # get golang for linux
    # TODO: check ~/sdk/go and clean
    curl -s https://dl.google.com/go/go${GOVER}.${OSTYPE,}-amd64.tar.gz | tar xzv -C ~/sdk/
    if [[ $? -ne 0 ]]; then
        err "golang install failed!"
        exit 1
    fi
    success Golang ${GOVER}
    exit 0
}

InstallGo
