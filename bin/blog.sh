#!/usr/bin/env bash
# GO111MODULE=off go get -u -v golang.org/x/blog
if [[ ! -f "$HOME/go/bin/blog" ]]; then
    echo "not found $HOME/go/bin/blog. installing"
    GO111MODULE=off go get -u -v golang.org/x/blog
fi
if [[ "$#" -ne 3 ]]; then
   echo "Usage: blog.sh 0.0.0.0 3999 contents/";
   echo "$#"
   exit 1;
fi
blog -reload -http "$1":"$2" -template "$(go env GOPATH)/src/golang.org/x/blog/template" -static "$(go env GOPATH)/src/golang.org/x/blog/static" -website "$(go env GOPATH)/src/golang.org/x/website/content/static" -content "$3"
