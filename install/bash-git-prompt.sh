#!/usr/bin/env bash
if [[ -d $HOME/.bash-git-prompt ]]; then
    mv $HOME/.bash-git-prompt $HOME/backupdir/.bash-git-prompt.${EPOCHSECONDS}
    echo "moved $HOME/.bash-git-promt to $HOME/backupdir/.bash-git-prompt.${EPOCHSECONDS}"
fi
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
exit 0
