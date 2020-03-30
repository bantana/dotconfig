#!/usr/bin/env bash
#curl -sL https://deb.nodesource.com/setup_10.x | sudo bash
#sudo apt update
#sudo apt -y install gcc g++ make
#sudo apt -y install nodejs
#curl -sL install-node.now.sh/lts | sh

# curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt-get update && sudo apt-get install yarn

if [[ "$(uname -s)" == "Linux" ]]; then
    echo ">>> Found Linux OS ..."
    # check ubuntu
    if [[ "$(lsb_release -is)" == "Ubuntu" ]]; then
        echo ">>> Found Ubuntu OS"
        # curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
        curl -sL install-node.now.sh/lts |sudo -E bash -
        # sudo apt update
        # sudo apt -y install gcc g++ make
        # sudo apt -y install nodejs
    fi
fi
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo ">>> Found Darwin OS ..."
    brew install node@12
fi


if [[ ! -d ~/.npm-global ]]; then
    mkdir -p ~/.npm-global
fi

if [[ ! -f ~/.npmrc ]]; then
    npm config set prefix='~/.npm-global'
fi
source ~/.profile
exit 0
