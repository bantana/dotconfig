#!/usr/bin/env bash
# GO111MODULE=off go get -u -v golang.org/x/tools/cmd/present
if [[ $1 -eq "" ]]; then
   echo "Usage: present.sh 0.0.0.0:3999";
   exit 1;
fi
present -http "$1" -base "$(go env GOPATH)/src/golang.org/x/tools/cmd/present" -orighost 'localhost'
