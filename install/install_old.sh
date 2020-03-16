#!/usr/bin/env bash
# my dotfiles

git clone git@iohttps.com:live/dotfiles.git ~/.config

# install brew
# sh ~/.config/install/brew.list
## or
brew bundle --file ../Brewfile

# install yarn and dependencies
sh ~/.config/install/yarn.sh

# install golang
mkdir -p ~/sdk
curl https://dl.google.com/go/go1.12.9.darwin-amd64.tar.gz | tar xzv -C ~/sdk

# upgrade new golang version ?
# go get -v golang.org/dl/go1.13beta1

## install neovim plugin
nvim +qall

## install neovim vim-go binaraies

nvim ~/tmp/test.go +GoInstallBinaries +qall

# or use :GoUpdateBinaries
nvim ~/tmp/test.go +GoUpdateBinaries +qall

# update coc.nvim dependencies extensions
# extensions id defined at ~/.config/coc/extensions/package.json

nvim +CocInstall +qall

# dart-lang
brew tap dart-lang/dart
brew install dart
