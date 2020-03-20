#!/usr/bin/env bash

err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

OSTYPE="$(uname -s)"

if [[ "$OSTYPE" == "Linux" ]]; then
    echo ">>> Found Linux OS ..."
    # check ubuntu
    if [[ "$(lsb_release -is)" == "Ubuntu" ]]; then
        echo ">>> Found Ubuntu OS"
	#sudo curl -x $HTTP_PROXY -L "https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage" -o /usr/local/bin/nvim && sudo chmod +x /usr/local/bin/nvim
	source ~/.profile  && proxy 
	sudo curl -sL "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -o /usr/local/bin/nvim && sudo chmod +x /usr/local/bin/nvim
        #sudo snap install nvim --beta --classic >&2
        if [[ $? -ne 0 ]]; then
            err "nvim install failed!"
            exit 1
        fi
        # TODO: "snap install nvim --classic" 检测到already installed, 仍然会返回状态0.
    fi
    echo ">>> SUCCESS: nvim installed!" 
    exit 0
fi

if [[ "$OSTYPE" == "Darwin" ]]; then
    echo ">>> Found Darwin OS ..."
    brew install neovim
    # TODO: test brew return value
    # brew bundle --file ../Brewfile
fi

# return success
exit 0
