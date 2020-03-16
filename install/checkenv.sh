#!/usr/bin/env bash

if [[ -d "$HOME/.config" ]]; then
    echo "directory .config is exist, you must manual backup .config directory."
     exit 1
 else
    echo "git clone remote .config"
    git clone git@iohttps.com:live/dotconfig.git ~/.config
    if [[ $? -ne 0 ]]; then
        echo "ERROR>>> error code: $?, git clone failed!"
        exit 1
    fi
fi


# create a backup direcotry
echo "create a backup dir $HOME/backupdir"
mkdir -p "$HOME/backupdir"


OSTYPE=$(uname -s)

if [[ "$OSTYPE" == "Linux" ]]; then
    if [[ -f $HOME/.profile ]]; then
        echo "backup $HOME/.profile to backupdir ..."
        mv "$HOME/.profile" "$HOME/backupdir/.profile.${EPOCHSECONDS}"
    fi
    ln -sf $HOME/.config/env/.profile ~/.profile
fi

if [[ "$OSTYPE" == "Darwin" ]]; then
    if [[ -f $HOME/.bash_profile ]]; then
        echo "backup $HOME/.bash_profile to backupdir ..."
        mv "$HOME/.bash_profile" "$HOME/backupdir/.bash_profile.${EPOCHSECONDS}"
    fi
    ln -sf $HOME/.config/env/.bash_profile ~/.bash_profile
fi

if [[ -f $HOME/.tmux.conf ]]; then
    echo "backup $HOME/.tmux.conf to backupdir ..."
    mv "$HOME/.tmux.conf" "$HOME/backupdir/.tmux.conf.${EPOCHSECONDS}"
fi
ln -sf $HOME/.config/env/.tmux.conf ~/.tmux.conf

if [[ -f $HOME/.gitconfig ]]; then
    echo "backup $HOME/.gitconfig to backupdir ..."
    mv "$HOME/.gitconfig" "$HOME/backupdir/.gitconfig.${EPOCHSECONDS}"
fi
ln -sf $HOME/.config/env/.gitconfig ~/.gitconfig
exit 0
