#!/usr/bin/env bash
set -e 

if [[ -f ~/.profile ]]; then
    source ~/.profile
fi
if [[ -f ~/.bash_profile ]]; then
    source ~/.bash_profile
fi

npm i -g npm
hash -r
npm i -g yarn
hash -r
yarn global add \
    typescript \
    coc.nvim \
    bash-language-server \
    npm-check-updates \
    vite \
    rollup \
    vls
    # dockerfile-language-server-nodejs \

# prettier
# yarn global add prettier cause a bug, see ~/.npm-global/bin

# option
# neovim prettier parcel
