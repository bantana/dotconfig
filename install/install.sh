#!/usr/bin/env bash

# bantana

# get dotconfig
bash ./checkenv.sh

# reload ./profile
source ~/.profile && proxy

# TODO: build-essential only linux
bash ./build-essential.sh

# c/c++ language
bash ./ccls.sh

# install golang
bash ./golang.sh

# node@10
bash ./node10.sh

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
nvim +CocInstall coc-yaml coc-json coc-snippets coc-pairs coc-vimlsp coc-git coc-diagnostic
