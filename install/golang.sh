#!/usr/bin/env bash

err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

success() {
    echo ">>> SUCCESS: $1 $2 installed!"
}

# gover="1.14.4"
gover=$(curl --silent https://golang.org/doc/devel/release.html | grep -Eo 'go[0-9]+(\.[0-9]+)+' | sort -V | uniq | tail -1|sed 's/go//')
echo "found the lastet version ${gover}"
ostypes="$(uname -s)"
if [[ -f ~/sdk/go/bin/go ]]; then
    current_gover="$(go version|awk '{print $3}'|sed 's/go//')"
    echo "local current go version ${current_gover}"
fi

if [[ ${current_gover} > ${gover} ]]; then
    echo "The current version ${current_gover} is newer than what you will install ${gover}"
    exit 1
fi
if [ "${current_gover}" == "${gover}" ]; then
    echo "already has equally go version."
    exit 1
fi
function InstallGo() {
    echo ">>> Found $ostypes OS ..."
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
    success Golang "${gover}"
    unset ostypes
    unset gover
    exit 0
}

InstallGo

# go get -u -v github.com/cespare/reflex
# GO111MODULE=off go get -u -v golang.org/x/blog
# GO111MODULE=off go get -u -v golang.org/x/tools/cmd/present
