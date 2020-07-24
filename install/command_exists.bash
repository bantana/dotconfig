#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function command_exists() {
    command -v "$1" > /dev/null 2>&1
}

# if ! command_exists nogo; then
#     echo "not found nogo command"
#     exit 1
# fi
# echo "founded nogo, do something!"

# if command_exists go; then
#     echo "go exists"
# fi
#
# if command_exists tatata; then
#     echo "tatata i like u"
# else
#     echo "tatata where are you?"
# fi
#
# if ! hash go 2>/dev/null
# then
#     echo "'go' was not found in PATH"
# else
#     echo "founded go exist in $(command -v go)"
# fi
