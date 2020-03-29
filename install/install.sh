#!/usr/bin/env bash

# bantana

# get dotconfig
bash ./checkenv.sh

# reload ./profile
if [[ "$(uname -s)" == "Linux" ]]; then
    source "$HOME/.profile" #  && proxy
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
    source "$HOME/.bash_profile" #  && proxy
fi

# TODO: build-essential only linux
# bash ./build-essential.sh

# c/c++ language
bash ./clangd.sh

# rg, shellcheck, shfmt, ag, etc. tools
bash ./linuxtools.sh

# install golang
bash ./golang.sh

# node@10
bash ./node12.sh

# yarn
bash ./yarn.sh

# neovim
bash ./neovim.sh

# bash-git-prompt
bash ./bash-git-prompt.sh


# nvim plugin
nvim +PlugInstall +qall

# nvim vim-go
nvim ~/tmp/test.go +GoInstallBinaries +qall

# nvim CocInstall
# nvim -c 'CocInstall coc-yaml coc-json coc-snippets coc-pairs coc-vimlsp coc-git coc-diagnostic coc-marketplace'
