#!/usr/bin/env bash
function cleancargo() {
    local current_dir="$(pwd)"

    if [[ "$#" -ne 1 ]]; then
        echo "Usage: ${FUNCNAME[0]} \$path"
        return 1
    fi

    local result=`find $1 -type d -name target|xargs --no-run-if-empty -I{} echo 'cd '$current_dir'/{}/.. && cargo clean -v;'`
    if [[ -z "$result" ]]; then
        echo "not found cargo build target directories, not need run cargo clean"
        return 1
    fi
    echo $result|bash -
    unset current_dir
    unset result
    echo "cleaned done!"
}

function cleanswift() {
    local current_dir="$(pwd)"

    if [[ "$#" -ne 1 ]]; then
        echo "Usage: ${FUNCNAME[0]} \$path"
        return 1
    fi

    # local result=`find $1 -type d -name .build|xargs --no-run-if-empty -I{} echo 'cd '$current_dir'/{}/.. && swift package clean;'`
    local result=`find $1 -type d -name .build|xargs --no-run-if-empty -I{} echo 'rm -rf '$current_dir'/{}/../.build && echo "removed '$current_dir'/{}/../.build";'`
    if [[ -z "$result" ]]; then
        echo "not found swift build target directories, not need run swift package clean"
        return 1
    fi
    echo $result|bash -E 

    unset current_dir
    unset result
    echo "cleaned done!"
}

function checkenv() {
    command printenv PATH | sed 's/:/\n/g' | sort | uniq -c
}

function mkcd() {
    command mkdir "$1" && cd "$_" || return
}

function proxy() {
    echo 'Setting variable "http[s]_proxy"...'
    if [[ $(uname -s) == "Darwin" ]]; then
        export HTTP_PROXY="http://127.0.0.1:2000"
    fi
    if [[ $(uname -s) == "Linux" ]]; then
        export HTTP_PROXY="${proxy}"
    fi
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
        ip addr | grep -v "inet6" | grep -E "inet.*brd.*scope"| grep -Po 'inet \K[\d.]+'
    fi
}

function whichport() {
    if [[ -z $1 ]]; then
        echo "Usage: whichport \$processname" 
        return 1
    fi
    if [[ $(uname -s) == "Darwin" ]]; then
        lsof -i -P -n | grep LISTEN|grep $1 | head -1 | awk '{print $2}'
    fi
    if [[ $(uname -s) == "Linux" ]]; then
        sudo lsof -i -P -n | grep LISTEN|grep $1| head -1 | awk '{print $2}'
    fi
}

function topstat() {
    local length=`expr length "$1"`
    if [[ $length -gt 9 ]]; then
        echo "process name length use first 9 characters"
    fi
    top -p $(whichport $1)
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

function sysupdate() {
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

##!/usr/bin/env bash
##     --slave /usr/bin/$1 $1 /usr/bin/$1-\${version} \\

function register_clang_version {
    local version=$1
    local priority=$2

    update-alternatives \
        --install /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-${version} ${priority} \
        --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-${version} \
        --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-${version} \
        --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-${version} \
        --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-${version} \
        --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-${version} \
        --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-${version} \
        --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-${version} \
        --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-${version} \
        --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-${version} \
        --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-${version} \
        --slave   /usr/bin/llvm-mcmarkup     llvm-mcmarkup    /usr/bin/llvm-mcmarkup-${version} \
        --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-${version} \
        --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-${version} \
        --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-${version} \
        --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-${version} \
        --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-${version} \
        --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-${version} \
        --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-${version} \
        --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-${version} \
        --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-${version}

    update-alternatives \
        --install /usr/bin/clang                 clang                 /usr/bin/clang-${version} ${priority} \
        --slave   /usr/bin/clang++               clang++               /usr/bin/clang++-${version}  \
        --slave   /usr/bin/asan_symbolize        asan_symbolize        /usr/bin/asan_symbolize-${version} \
        --slave   /usr/bin/c-index-test          c-index-test          /usr/bin/c-index-test-${version} \
        --slave   /usr/bin/clang-check           clang-check           /usr/bin/clang-check-${version} \
        --slave   /usr/bin/clang-cl              clang-cl              /usr/bin/clang-cl-${version} \
        --slave   /usr/bin/clang-cpp             clang-cpp             /usr/bin/clang-cpp-${version} \
        --slave   /usr/bin/clang-format          clang-format          /usr/bin/clang-format-${version} \
        --slave   /usr/bin/clang-format-diff     clang-format-diff     /usr/bin/clang-format-diff-${version} \
        --slave   /usr/bin/clang-import-test     clang-import-test     /usr/bin/clang-import-test-${version} \
        --slave   /usr/bin/clang-include-fixer   clang-include-fixer   /usr/bin/clang-include-fixer-${version} \
        --slave   /usr/bin/clang-offload-bundler clang-offload-bundler /usr/bin/clang-offload-bundler-${version} \
        --slave   /usr/bin/clang-query           clang-query           /usr/bin/clang-query-${version} \
        --slave   /usr/bin/clang-rename          clang-rename          /usr/bin/clang-rename-${version} \
        --slave   /usr/bin/clang-reorder-fields  clang-reorder-fields  /usr/bin/clang-reorder-fields-${version} \
        --slave   /usr/bin/clang-tidy            clang-tidy            /usr/bin/clang-tidy-${version} \
        --slave   /usr/bin/lldb                  lldb                  /usr/bin/lldb-${version} \
        --slave   /usr/bin/lldb-server           lldb-server           /usr/bin/lldb-server-${version}
    }

# register_clang_version $1 $2
function fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
