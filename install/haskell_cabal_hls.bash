#!/usr/bin/env bash
if [[ $(uname -s) == "Linux" ]]; then
    mkdir -p ~/tmp/haskell
    cd ~/tmp/haskell

    wget -c https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
    tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
    mv cabal /usr/local/bin/cabal

    ## forgot ?
    # cabal update

    wget -c https://downloads.haskell.org/~ghc/8.10.1/ghc-8.10.1-x86_64-deb10-linux.tar.xz
    tar -xf ghc-8.10.1-x86_64-deb10-linux.tar.xz
    cd ghc-8.10.1/
    ./configure
    make
    make install

    # in china
    sed -i 's/repository hackage.haskell.org/repository mirrors.tuna.tsinghua.edu.cn/' ~/.cabal/config
    sed -i 's/url: http:\/\/hackage.haskell.org/url: http:\/\/mirrors.tuna.tsinghua.edu.cn\/hackage/' ~/.cabal/config
    sed -i 's/  -- secure: True/--  -- secure: True/' ~/.cabal/config
    sed -i 's/  -- root-keys:/--  -- root-keys:/' ~/.cabal/config
    sed -i 's/  -- key-threshold: 3/--  -- key-threshold: 3/' ~/.cabal/config

    mkdir -p cabal_update
    cd cabal_update
    cabal update
    cd ..

    git clone git@github.com:haskell/haskell-language-server.git
    cd haskell-language-server
    ./cabal-hls-install hls
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install ghc cabal-install

    # in china
    sed -i '' -e 's/repository hackage.haskell.org/repository mirrors.tuna.tsinghua.edu.cn/' ~/.cabal/config
    sed -i '' -e 's/url: http:\/\/hackage.haskell.org/url: http:\/\/mirrors.tuna.tsinghua.edu.cn\/hackage/' ~/.cabal/config
    sed -i '' -e 's/  -- secure: True/--  -- secure: True/' ~/.cabal/config
    sed -i '' -e 's/  -- root-keys:/--  -- root-keys:/' ~/.cabal/config
    sed -i '' -e 's/  -- key-threshold: 3/--  -- key-threshold: 3/' ~/.cabal/config

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
