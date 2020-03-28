#!/usr/bin/env bash
function checkenv() {
    command printenv PATH | sed 's/:/\n/g' | sort | uniq -c
}
function mkcd() {
    command mkdir "$1" && cd "$_" || return
}

function proxy() {
    echo 'Setting variable "http[s]_proxy"...'
    export HTTP_PROXY="http://192.168.64.1:2000"
    export HTTPS_PROXY=$HTTP_PROXY
    export NO_PROXY="127.0.0.1, localhost, *.local, 192.168.64/24, 169.254/16, registry.npmjs.com"
    echo 'Done!'
}

function noproxy() {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset NO_PROXY
    echo -e "\nProxy environment variables removed!"
}

function myip() {
    if [[ $(uname -s) == "Darwin" ]]; then
        ifconfig | grep -E "inet.*netmask.*broadcast"
    fi
    if [[ $(uname -s) == "Linux" ]]; then
        ip addr | grep -v "inet6" | grep -E "inet.*brd.*scope"
    fi
}

function lxchost() {
    ssh "$(lxc list | grep -i "$1" | awk '{print $6}')"
}

function addToPATH() {
    case ":$PATH:" in
        *":$1:"*) : ;; # already there
        *) PATH="$1:$PATH" ;; # or PATH="$PATH:$1"
    esac
}
function trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"%${var##*[![:space:]]}"}"
    printf '%s' "$var"
}

function sysupdae() {
if [[ "$(uname -s)" == "Linux" ]]; then
    echo ">>> Found Linux OS ..."
    # check ubuntu
    if [[ "$(lsb_release -is)" == "Ubuntu" ]]; then
        echo ">>> Found Ubuntu OS"
        sudo apt -y update; sudo apt -y upgrade ; sudo apt -y autoremove; sudo apt clean --dry-run
    fi
fi
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo ">>> Found Darwin OS ..."
    START_DATE=$(date +"%d.%m.%Y | %H:%M:%S")
    echo "--- Updater for macOS started at: $START_DATE ---"

    echo
    echo "- Updating \"macOS\" -"
    softwareupdate --install --all

    echo
    echo "- Updating \"brew\" -"
    brew update
    brew upgrade
    brew cask upgrade
    brew cleanup 
    # brew cask cleanup

    echo
    echo "- Updating \"gem\" -"
    gem update --system
    gem update
    gem cleanup

    END_DATE=$(date +"%d.%m.%Y | %H:%M:%S")
    echo
    echo "--- Updater for macOS finished at: $END_DATE ---"
fi
}
