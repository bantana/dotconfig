#!/usr/bin/env bash

function addToPATH() {
    case ":$PATH:" in
        *":$1:"*) : ;; # already there
        *) PATH="$1:$PATH" ;; # or PATH="$PATH:$1"
    esac
}

# https://goproxyio
if [[ -d ~/sdk/go ]]; then
    export GO111MODULE=on
    go_bin_path="$HOME/sdk/go/bin:$HOME/go/bin"
    addToPATH "${go_bin_path}"
    unset go_bin_path

    # Go version >=1.13
    go env -w GOPROXY=https://goproxy.io,direct
    # Set environment variable allow bypassing the proxy for selected modules
    go env -w GOPRIVATE=*.iohttps.com
fi
echo "debug go"
