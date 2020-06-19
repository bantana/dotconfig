#!/usr/bin/env bash

git clone https://github.com/cheat/cheat.git ~/tmp/cheat && cd ~/tmp/cheat
make && make install

if [[ ! -d "~/.config/cheat/cheatsheets/" ]]; then
    mkdir -p ~/.config/cheat/cheatsheets/
fi

if [[ ! -d "~/.config/cheat/cheatsheets/community/" ]]; then
    cd ~/.config/cheat/cheatsheets && git clone https://github.com/cheat/cheatsheets.git community
fi

if [[ ! -d "~/.config/cheat/cheatsheets/personal/" ]]; then
    cd ~/.config/cheat/cheatsheets && git clone git@iohttps.com:bantana/cheat.git personal
fi
