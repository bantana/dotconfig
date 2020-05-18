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

    git clone git@github.com:haskell/haskell-language-server.git
    cd haskell-language-server
    ./cabal-hls-install hls
fi
if [[ $(uname -s) == "Darwin" ]]; then
    brew install ghc cabal-install

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
