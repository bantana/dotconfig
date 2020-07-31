#!/usr/bin/env bash
set -e

err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

success() {
    echo ">>> SUCCESS: $1 $2 installed!"
}

# gover="1.14.4"
if [ "$1" != "" ]; then
    gover="$1"
else
    gover=$(curl --silent https://golang.org/doc/devel/release.html | grep -Eo 'go[0-9]+(\.[0-9]+)+' | sort -V | uniq | tail -1|sed 's/go//')
fi
echo "found the lastet version ${gover}"

ostypes="$(uname -s)"
if [[ -f ~/sdk/go/bin/go ]]; then
    current_gover="$(go version|awk '{print $3}'|sed 's/go//')"
    echo "local current go version ${current_gover}"
fi

# go get golang.org/dl/go"${gover}"

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
        # first get golang
        curl -s https://dl.google.com/go/go"${gover}.${ostypes,}"-amd64.tar.gz | tar xzv -C ~/sdk/ && cd ~/sdk && mv go "go${gover}" && ln -s "go${gover}" go
    fi
    if [[ -d ~/sdk/go ]]; then
        if [[ $(go version |awk '{print $3}'|awk -F "o" '{print $2}') == "$gover" ]]; then
            echo "go version $gover already"
            exit 0
        fi
    fi
    go get golang.org/dl/go"${gover}" && go"${gover}" download && cd ~/sdk && ln -sfn go"${gover}" go
    if [[ $? -ne 0 ]]; then
        err "golang install failed!"
        echo "==================================="
        echo "try to Usage: bash go.bash ${gover}"
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
