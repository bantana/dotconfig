#!/usr/bin/env bash
if [[ $(uname -s) == "Linux" ]]; then
    mkdir -p ~/tmp/haskell
    cd ~/tmp/haskell

    if [[ $(lsb_release -cs) == "bionic" ]]; then
        sudo apt install libicu-dev libtinfo-dev libgmp-dev
        wget -c http://ftp.br.debian.org/debian/pool/main/n/ncurses/libtinfo6_6.2-1_amd64.deb
        sudo dpkg -i libtinfo6_6.2-1_amd64.deb
    fi

    wget -c https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
    tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
    sudo mv cabal /usr/local/bin/cabal

    wget -c https://downloads.haskell.org/~ghc/8.10.1/ghc-8.10.1-x86_64-deb10-linux.tar.xz
    tar -xf ghc-8.10.1-x86_64-deb10-linux.tar.xz
    cd ghc-8.10.1/
    ./configure
    make
    sudo make install

    if [[ ! -z "$HTTPS_PROXY" ]]; then
        # todo: check ip on china
        echo "HTTPS_PROXY founded, try modify ~/.cabal/config repository " 
        # generate ~/.cabal/config
        cabal user-config init 
        sed -i 's/repository hackage.haskell.org/repository mirrors.tuna.tsinghua.edu.cn/' ~/.cabal/config
        sed -i 's/url: http:\/\/hackage.haskell.org/url: http:\/\/mirrors.tuna.tsinghua.edu.cn\/hackage/' ~/.cabal/config
        sed -i 's/  -- secure: True/  -- secure: False/' ~/.cabal/config
        sed -i 's/  -- root-keys:/  -- root-keys:/' ~/.cabal/config
        sed -i 's/  -- key-threshold: 3/  -- key-threshold:/' ~/.cabal/config
    fi

    [[ ! -d "cabal_update" ]] && mkdir -p cabal_update
    cd cabal_update
    echo "cabal update ..."
    cabal update
    cd ..
    [[ -d "./cabal_update" ]] && rm -rf cabal_update

    git clone git@github.com:haskell/haskell-language-server.git
    cd haskell-language-server
    ./cabal-hls-install hls
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install ghc cabal-install

    if [[ ! -z "$HTTPS_PROXY" ]]; then
        # todo: check ip on china
        echo "HTTPS_PROXY founded, try modify ~/.cabal/config repository " 
        # generate ~/.cabal/config
        cabal user-config init 
        sed -i 's/repository hackage.haskell.org/repository mirrors.tuna.tsinghua.edu.cn/' ~/.cabal/config
        sed -i 's/url: http:\/\/hackage.haskell.org/url: http:\/\/mirrors.tuna.tsinghua.edu.cn\/hackage/' ~/.cabal/config
        sed -i 's/  -- secure: True/  -- secure: False/' ~/.cabal/config
        sed -i 's/  -- root-keys:/  -- root-keys:/' ~/.cabal/config
        sed -i 's/  -- key-threshold: 3/  -- key-threshold:/' ~/.cabal/config
    fi

    mkdir -p ~/tmp/haskell
    cd ~/tmp/haskell
    git clone git@github.com:haskell/haskell-language-server.git
    cd haskell-language-server
    ./cabal-hls-install hls
fi

cat <<Endofmessage
-------------------------------------
# ~/.profile or ~/.bash_profile
# haskell cabal
if [[ -d "\$HOME/.cabal/bin" ]]; then
  export PATH="\$HOME/.cabal/bin:\$PATH"
fi
-------------------------------------
Endofmessage

cat <<Cleanmessage
-------------------------------------
# ~/tmp/haskell maybe need clean
rm -r ~/tmp/haskell
-------------------------------------
Cleanmessage
