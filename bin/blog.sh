#!/usr/bin/env bash
# GO111MODULE=off go get -u -v golang.org/x/blog
if [[ $1 -eq "" ]]; then
   echo "Usage: blog.sh 0.0.0.0:3999";
   exit 1;
fi

blog -reload -http $1 -template "$(go env GOPATH)/src/golang.org/x/blog/template" -static "$(go env GOPATH)/src/golang.org/x/blog/static" -website "$(go env GOPATH)/src/golang.org/x/website/content/static/" -content "./"
