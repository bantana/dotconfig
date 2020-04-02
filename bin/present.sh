#!/usr/bin/env bash
# GO111MODULE=off go get -u -v golang.org/x/tools/cmd/present
if [[ ! -f "$HOME/go/bin/present" ]]; then
    echo "not foun $HOME/go/bin/present. installing...."
    GO111MODULE=off go get -u -v golang.org/x/tools/cmd/present
fi
if [[ "$#" -ne 2 ]]; then
   echo "Usage: present.sh 0.0.0.0 3999";
   echo "$#";
   exit 1;
fi
present -http "$1":"$2" -base "$(go env GOPATH)/src/golang.org/x/tools/cmd/present" -orighost "$1"
